package main

import "core:math/linalg/glsl"
import "core:math"
import "core:strconv"
import "core:strings"
import "core:slice"
import "core:os"
import "core:io"
import "core:c"
import "core:log"

import "base:runtime"

import "vendor:sdl3"
import stbi "vendor:stb/image"

import "glad"

main :: proc() {
    context.logger = log.create_console_logger()
    defer log.destroy_console_logger(context.logger)
    
    if !sdl3.Init(sdl3.INIT_VIDEO) {
        log.fatalf("Failed to initialize SDL3, message: %s", sdl3.GetError())
        return
    }
    defer sdl3.Quit()

    when ODIN_OS == .Darwin {
        sdl3.GL_SetAttribute(.CONTEXT_FLAGS, i32(sdl3.GLContextFlag.FORWARD_COMPATIBLE))
        sdl3.GL_SetAttribute(.CONTEXT_PROFILE_MASK, i32(sdl3.GLProfile.COMPATIBILITY))
        sdl3.GL_SetAttribute(.CONTEXT_MAJOR_VERSION, 3)
        sdl3.GL_SetAttribute(.CONTEXT_MINOR_VERSION, 3)
    } else {
        sdl3.GL_SetAttribute(.CONTEXT_PROFILE_MASK, i32(sdl3.GLProfileFlag.ES))
        sdl3.GL_SetAttribute(.CONTEXT_MAJOR_VERSION, 3)
        sdl3.GL_SetAttribute(.CONTEXT_MINOR_VERSION, 2)
    }

    window := sdl3.CreateWindow("GLES 3.0 Renderer", 1152, 648, sdl3.WINDOW_OPENGL | sdl3.WINDOW_RESIZABLE)
    if window == nil {
        log.fatalf("Failed to create valid OpenGL window, message: %s", sdl3.GetError())
        return
    }
    defer sdl3.DestroyWindow(window)

    ctx := sdl3.GL_CreateContext(window)
    if ctx == nil {
        log.fatalf("Failed to create OpenGL context, message: %s", sdl3.GetError())
        return
    }
    defer sdl3.GL_DestroyContext(ctx)

    if !sdl3.GL_MakeCurrent(window, ctx) {
        log.fatalf("Failed to make OpenGL context current, message: %s", sdl3.GetError())
        return
    }

    if !sdl3.GL_SetSwapInterval(0) {
        log.warnf("Failed to set OpenGL Swap Interval, message: %s", sdl3.GetError())
    }

    gl := glad.gl_context{}
    gl_version := glad.LoadGLES2Context(&gl, cast(glad.load_proc) sdl3.GL_GetProcAddress)
    if gl_version == 0 {
        log.fatalf("Failed to load OpenGL ES 3.0 on the current system!")
        return
    }

    log.debugf("OpenGL %d.%d", gl_version / 10000, gl_version % 10000)

    quad := generate_quad(&gl)
    defer gl.DeleteBuffers(1, &quad.indices)
    defer gl.DeleteBuffers(1, &quad.vertices)

    test_shader := load_shader(&gl, "test.frag", "test.vert")
    defer gl.DeleteProgram(test_shader)

    projection_loc := gl.GetUniformLocation(test_shader, "projection")
    transform_loc := gl.GetUniformLocation(test_shader, "transform")

    cow := load_texture(&gl, "meAndDoodiiFromBeef.jpg")
    defer gl.DeleteTextures(1, &cow.texture)

    projection: matrix[4, 4]f32 = glsl.mat4Ortho3d(0, 1152, 648, 0, -1, 1)
    transform: matrix[4, 4]f32
    transform = glsl.mat4Translate({0, 0, 0}) * glsl.mat4Scale({1500, 500, 1})

    event: sdl3.Event
    main_loop: for {
        for sdl3.PollEvent(&event) {
            #partial switch event.type {
                case .QUIT:
                    break main_loop
                case .WINDOW_RESIZED:
                    projection = glsl.mat4Ortho3d(0, f32(event.window.data1), f32(event.window.data2), 0, -1, 1)
                    gl.Viewport(0, 0, event.window.data1, event.window.data2)
                case:
            }
        }

        gl.ClearColor(0.0, 0.0, 0.0, 1.0)
        gl.Clear(glad.COLOR_BUFFER_BIT)

        gl.UseProgram(test_shader)
        gl.UniformMatrix4fv(projection_loc, 1, glad.FALSE, raw_data(&projection))
        gl.UniformMatrix4fv(transform_loc, 1, glad.FALSE, raw_data(&transform))

        gl.ActiveTexture(glad.TEXTURE0)
        gl.BindTexture(glad.TEXTURE_2D, cow.texture)
        gl.BindVertexArray(quad.vao)
        gl.BindBuffer(glad.ELEMENT_ARRAY_BUFFER, quad.indices)
        gl.DrawElements(glad.TRIANGLES, 6, glad.UNSIGNED_INT, nil)

        sdl3.GL_SwapWindow(window)
    }
}

generate_quad :: proc(gl: ^glad.gl_context) -> struct {vao: u32, vertices: u32, indices: u32} {
    vao: u32
    gl.GenVertexArrays(1, &vao)
    gl.BindVertexArray(vao)

    vertices: [16]f32 = {
        0.0, 1.0, 0.0, 1.0, // top left
        0.0, 0.0, 0.0, 0.0, // bottom left
        1.0, 1.0, 1.0, 1.0, // top right
        1.0, 0.0, 1.0, 0.0, // bottom right
    }

    vertice_buffer: u32
    gl.GenBuffers(1, &vertice_buffer)
    gl.BindBuffer(glad.ARRAY_BUFFER, vertice_buffer)
    gl.BufferData(glad.ARRAY_BUFFER, size_of(f32) * len(vertices), &vertices, glad.STATIC_DRAW)

    indices: [6]u32 = {
        2, 3, 0,
        3, 1, 0,
    }
    
    indice_buffer: u32
    gl.GenBuffers(1, &indice_buffer)
    gl.BindBuffer(glad.ELEMENT_ARRAY_BUFFER, indice_buffer)
    gl.BufferData(glad.ELEMENT_ARRAY_BUFFER, size_of(u32) * len(indices), &indices, glad.STATIC_DRAW)

    gl.VertexAttribPointer(0, 2, glad.FLOAT, glad.FALSE, 4 * size_of(f32), nil)
    gl.EnableVertexAttribArray(0)

    gl.VertexAttribPointer(1, 2, glad.FLOAT, glad.FALSE, 4 * size_of(f32), rawptr(uintptr(2 * size_of(f32))))
    gl.EnableVertexAttribArray(1)

    return {vao, vertice_buffer, indice_buffer}
}

load_texture :: proc(gl: ^glad.gl_context, path: cstring) -> struct {w: i32, h: i32, texture: u32} {
    width, height: i32
    pixels := stbi.load(path, &width, &height, nil, 4)
    if pixels == nil {
        log.errorf("Failed to load '%s', reason: %s", path, stbi.failure_reason())
        return {0, 0, 0}
    }
    
    texture: u32
    gl.GenTextures(1, &texture)
    gl.BindTexture(glad.TEXTURE_2D, texture)
    
    gl.TexParameteri(glad.TEXTURE_2D, glad.TEXTURE_WRAP_S, glad.REPEAT)
    gl.TexParameteri(glad.TEXTURE_2D, glad.TEXTURE_WRAP_T, glad.REPEAT)
    gl.TexParameteri(glad.TEXTURE_2D, glad.TEXTURE_MIN_FILTER, glad.LINEAR)
    gl.TexParameteri(glad.TEXTURE_2D, glad.TEXTURE_MAG_FILTER, glad.LINEAR)

    gl.TexImage2D(glad.TEXTURE_2D, 0, glad.RGBA, width, height, 0, glad.RGBA, glad.UNSIGNED_BYTE, pixels)
    stbi.image_free(pixels)

    return {width, height, texture}
}

bytes_to_cstring :: proc(bytes: []byte, allocator: runtime.Allocator = context.allocator) -> (cstring, runtime.Allocator_Error) {
    str := string(bytes)
    return strings.clone_to_cstring(str, allocator)
}

when ODIN_OS == .Darwin {
    SHADER_VERSION: cstring = "#version 330 core\n"
} else {
    SHADER_VERSION: cstring = "#version 320 es\n"
}

load_shader :: proc(gl: ^glad.gl_context, fragment_path: string, vertex_path: string, allocator: runtime.Allocator = context.allocator) -> u32 {
    os_err: os.Error
    alloc_err: runtime.Allocator_Error
    frag_src, vert_src: []byte
    frag_str, vert_str: cstring
    frag_id, vert_id, program_id: u32
    success, length: i32
    failure_log: [512]u8
    strs: [2]cstring = {SHADER_VERSION,  nil}
    lengths: [2]i32 = {i32(len(SHADER_VERSION)), 0}

    frag_src, os_err = os.read_entire_file(fragment_path, allocator)
    if os_err != nil {
        log.errorf("Failed to read shader '%s' with error %s.", fragment_path, os_err)
        return 0
    }

    frag_str, alloc_err = bytes_to_cstring(frag_src, allocator)
    delete(frag_src, allocator)
    if alloc_err != nil {
        log.errorf("Failed to clone shader string into cstring with error %s.", alloc_err)
        return 0
    }

    frag_id = gl.CreateShader(glad.FRAGMENT_SHADER)
    defer gl.DeleteShader(frag_id)

    strs[1] = frag_str
    lengths[1] = i32(len(frag_str))
    gl.ShaderSource(frag_id, 2, raw_data(&strs), raw_data(&lengths))
    delete(frag_str, allocator)

    gl.CompileShader(frag_id)
    gl.GetShaderiv(frag_id, glad.COMPILE_STATUS, &success)
    if success == 0 {
        gl.GetShaderInfoLog(frag_id, len(failure_log), nil, raw_data(&failure_log))
        log.errorf("Failed to compile fragment shader with error: %s", failure_log)
        return 0
    }

    vert_src, os_err = os.read_entire_file(vertex_path, allocator)
    if os_err != nil {
        log.errorf("Failed to read shader '%s' with error %s.", vertex_path, os_err)
        return 0
    }

    vert_str, alloc_err = bytes_to_cstring(vert_src, allocator)
    delete(vert_src, allocator)
    if alloc_err != nil {
        log.errorf("Failed to clone shader string into cstring with error %s.", alloc_err)
        return 0
    }

    vert_id = gl.CreateShader(glad.VERTEX_SHADER)
    defer gl.DeleteShader(vert_id)

    strs[1] = vert_str
    lengths[1] = i32(len(vert_str))
    gl.ShaderSource(vert_id, 2, raw_data(&strs), raw_data(&lengths))
    delete(vert_str, allocator)

    gl.CompileShader(vert_id)
    gl.GetShaderiv(vert_id, glad.COMPILE_STATUS, &success)
    if success == 0 {
        gl.GetShaderInfoLog(vert_id, len(failure_log), nil, raw_data(&failure_log))
        log.errorf("Failed to compile vertex shader with error: %s", failure_log)
        return 0
    }

    program_id = gl.CreateProgram()
    gl.AttachShader(program_id, frag_id)
    gl.AttachShader(program_id, vert_id)

    gl.LinkProgram(program_id)
    gl.GetProgramiv(program_id, glad.LINK_STATUS, &success)
    if success == 0 {
        gl.GetProgramInfoLog(program_id, len(failure_log), nil, raw_data(&failure_log))
        log.errorf("Failed to link shader program with error: %s", failure_log)
        return 0
    }

    return program_id
}