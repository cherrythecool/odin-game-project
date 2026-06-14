package glad

import c "core:c"

@(private)
LIB :: (
	     "./lib/glad.lib"      when ODIN_OS == .Windows
	else "./lib/glad_linux.a"  when ODIN_OS == .Linux
	else "./lib/glad_darwin.a" when ODIN_OS == .Darwin
	else "./lib/glad_wasm.o"   when ODIN_ARCH == .wasm32 || ODIN_ARCH == .wasm64p32
	else ""
)

when LIB != "" {
	when !#exists(LIB) {
		#panic("Could not find the compiled glad libraries, they can be compiled by running the respective build script for your platform.")
	}
}

when LIB != "" {
	foreign import lib { LIB }
} else {
	foreign import lib "system:glad"
}

load_proc :: proc "c" (name: cstring) -> proc "c" ()

@(default_calling_convention="c", link_prefix="glad")
foreign lib {
    LoadGLES2Context :: proc(ctx: ^gl_context, load: load_proc) -> c.int ---
}

gl_context :: struct {
    userptr: rawptr,
    es_v2_0: c.int,
    es_v3_0: c.int,
    es_v3_1: c.int,
    es_v3_2: c.int,
    ActiveShaderProgram: proc "c" (pipeline: GLuint, program: GLuint),
    ActiveTexture: proc "c" (texture: GLenum),
    AttachShader: proc "c" (program: GLuint, shader: GLuint),
    BeginQuery: proc "c" (target: GLenum, id: GLuint),
    BeginTransformFeedback: proc "c" (primitiveMode: GLenum),
    BindAttribLocation: proc "c" (program: GLuint, index: GLuint, #by_ptr name: GLchar),
    BindBuffer: proc "c" (target: GLenum, buffer: GLuint),
    BindBufferBase: proc "c" (target: GLenum, index: GLuint, buffer: GLuint),
    BindBufferRange: proc "c" (target: GLenum, index: GLuint, buffer: GLuint, offset: GLintptr, size: GLsizeiptr),
    BindFramebuffer: proc "c" (target: GLenum, framebuffer: GLuint),
    BindImageTexture: proc "c" (unit: GLuint, texture: GLuint, level: GLint, layered: GLboolean, layer: GLint, access: GLenum, format: GLenum),
    BindProgramPipeline: proc "c" (pipeline: GLuint),
    BindRenderbuffer: proc "c" (target: GLenum, renderbuffer: GLuint),
    BindSampler: proc "c" (unit: GLuint, sampler: GLuint),
    BindTexture: proc "c" (target: GLenum, texture: GLuint),
    BindTransformFeedback: proc "c" (target: GLenum, id: GLuint),
    BindVertexArray: proc "c" (array: GLuint),
    BindVertexBuffer: proc "c" (bindingindex: GLuint, buffer: GLuint, offset: GLintptr, stride: GLsizei),
    BlendBarrier: proc "c" (),
    BlendColor: proc "c" (red: GLfloat, green: GLfloat, blue: GLfloat, alpha: GLfloat),
    BlendEquation: proc "c" (mode: GLenum),
    BlendEquationSeparate: proc "c" (modeRGB: GLenum, modeAlpha: GLenum),
    BlendEquationSeparatei: proc "c" (buf: GLuint, modeRGB: GLenum, modeAlpha: GLenum),
    BlendEquationi: proc "c" (buf: GLuint, mode: GLenum),
    BlendFunc: proc "c" (sfactor: GLenum, dfactor: GLenum),
    BlendFuncSeparate: proc "c" (sfactorRGB: GLenum, dfactorRGB: GLenum, sfactorAlpha: GLenum, dfactorAlpha: GLenum),
    BlendFuncSeparatei: proc "c" (buf: GLuint, srcRGB: GLenum, dstRGB: GLenum, srcAlpha: GLenum, dstAlpha: GLenum),
    BlendFunci: proc "c" (buf: GLuint, src: GLenum, dst: GLenum),
    BlitFramebuffer: proc "c" (srcX0: GLint, srcY0: GLint, srcX1: GLint, srcY1: GLint, dstX0: GLint, dstY0: GLint, dstX1: GLint, dstY1: GLint, mask: GLbitfield, filter: GLenum),
    BufferData: proc "c" (target: GLenum, size: GLsizeiptr, data: rawptr, usage: GLenum),
    BufferSubData: proc "c" (target: GLenum, offset: GLintptr, size: GLsizeiptr, data: rawptr),
    CheckFramebufferStatus: proc "c" (target: GLenum) -> GLenum,
    Clear: proc "c" (mask: GLbitfield),
    ClearBufferfi: proc "c" (buffer: GLenum, drawbuffer: GLint, depth: GLfloat, stencil: GLint),
    ClearBufferfv: proc "c" (buffer: GLenum, drawbuffer: GLint, #by_ptr value: GLfloat),
    ClearBufferiv: proc "c" (buffer: GLenum, drawbuffer: GLint, #by_ptr value: GLint),
    ClearBufferuiv: proc "c" (buffer: GLenum, drawbuffer: GLint, #by_ptr value: GLuint),
    ClearColor: proc "c" (red: GLfloat, green: GLfloat, blue: GLfloat, alpha: GLfloat),
    ClearDepthf: proc "c" (d: GLfloat),
    ClearStencil: proc "c" (s: GLint),
    ClientWaitSync: proc "c" (sync: GLsync, flags: GLbitfield, timeout: GLuint64) -> GLenum,
    ColorMask: proc "c" (red: GLboolean, green: GLboolean, blue: GLboolean, alpha: GLboolean),
    ColorMaski: proc "c" (index: GLuint, r: GLboolean, g: GLboolean, b: GLboolean, a: GLboolean),
    CompileShader: proc "c" (shader: GLuint),
    CompressedTexImage2D: proc "c" (target: GLenum, level: GLint, internalformat: GLenum, width: GLsizei, height: GLsizei, border: GLint, imageSize: GLsizei, data: rawptr),
    CompressedTexImage3D: proc "c" (target: GLenum, level: GLint, internalformat: GLenum, width: GLsizei, height: GLsizei, depth: GLsizei, border: GLint, imageSize: GLsizei, data: rawptr),
    CompressedTexSubImage2D: proc "c" (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, width: GLsizei, height: GLsizei, format: GLenum, imageSize: GLsizei, data: rawptr),
    CompressedTexSubImage3D: proc "c" (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, zoffset: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, format: GLenum, imageSize: GLsizei, data: rawptr),
    CopyBufferSubData: proc "c" (readTarget: GLenum, writeTarget: GLenum, readOffset: GLintptr, writeOffset: GLintptr, size: GLsizeiptr),
    CopyImageSubData: proc "c" (srcName: GLuint, srcTarget: GLenum, srcLevel: GLint, srcX: GLint, srcY: GLint, srcZ: GLint, dstName: GLuint, dstTarget: GLenum, dstLevel: GLint, dstX: GLint, dstY: GLint, dstZ: GLint, srcWidth: GLsizei, srcHeight: GLsizei, srcDepth: GLsizei),
    CopyTexImage2D: proc "c" (target: GLenum, level: GLint, internalformat: GLenum, x: GLint, y: GLint, width: GLsizei, height: GLsizei, border: GLint),
    CopyTexSubImage2D: proc "c" (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, x: GLint, y: GLint, width: GLsizei, height: GLsizei),
    CopyTexSubImage3D: proc "c" (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, zoffset: GLint, x: GLint, y: GLint, width: GLsizei, height: GLsizei),
    CreateProgram: proc "c" () -> GLuint,
    CreateShader: proc "c" (gl_type: GLenum) -> GLuint,
    CreateShaderProgramv: proc "c" (gl_type: GLenum, count: GLsizei, #by_ptr strings: GLchar) -> GLuint,
    CullFace: proc "c" (mode: GLenum),
    DebugMessageCallback: proc "c" (callback: DebugProc, userParam: rawptr),
    DebugMessageControl: proc "c" (source: GLenum, gl_type: GLenum, severity: GLenum, count: GLsizei, #by_ptr ids: GLuint, enabled: GLboolean),
    DebugMessageInsert: proc "c" (source: GLenum, gl_type: GLenum, id: GLuint, severity: GLenum, length: GLsizei, #by_ptr buf: GLchar),
    DeleteBuffers: proc "c" (n: GLsizei, buffers: ^GLuint),
    DeleteFramebuffers: proc "c" (n: GLsizei, framebuffers: ^GLuint),
    DeleteProgram: proc "c" (program: GLuint),
    DeleteProgramPipelines: proc "c" (n: GLsizei, pipelines: ^GLuint),
    DeleteQueries: proc "c" (n: GLsizei, ids: ^GLuint),
    DeleteRenderbuffers: proc "c" (n: GLsizei, renderbuffers: ^GLuint),
    DeleteSamplers: proc "c" (count: GLsizei, samplers: ^GLuint),
    DeleteShader: proc "c" (shader: GLuint),
    DeleteSync: proc "c" (sync: GLsync),
    DeleteTextures: proc "c" (n: GLsizei, textures: ^GLuint),
    DeleteTransformFeedbacks: proc "c" (n: GLsizei, #by_ptr ids: GLuint),
    DeleteVertexArrays: proc "c" (n: GLsizei, #by_ptr arrays: GLuint),
    DepthFunc: proc "c" (func: GLenum),
    DepthMask: proc "c" (flag: GLboolean),
    DepthRangef: proc "c" (n: GLfloat, f: GLfloat),
    DetachShader: proc "c" (program: GLuint, shader: GLuint),
    Disable: proc "c" (cap: GLenum),
    DisableVertexAttribArray: proc "c" (index: GLuint),
    Disablei: proc "c" (target: GLenum, index: GLuint),
    DispatchCompute: proc "c" (num_groups_x: GLuint, num_groups_y: GLuint, num_groups_z: GLuint),
    DispatchComputeIndirect: proc "c" (indirect: GLintptr),
    DrawArrays: proc "c" (mode: GLenum, first: GLint, count: GLsizei),
    DrawArraysIndirect: proc "c" (mode: GLenum, indirect: rawptr),
    DrawArraysInstanced: proc "c" (mode: GLenum, first: GLint, count: GLsizei, instancecount: GLsizei),
    DrawBuffers: proc "c" (n: GLsizei, #by_ptr bufs: GLenum),
    DrawElements: proc "c" (mode: GLenum, count: GLsizei, gl_type: GLenum, indices: rawptr),
    DrawElementsBaseVertex: proc "c" (mode: GLenum, count: GLsizei, gl_type: GLenum, indices: rawptr, basevertex: GLint),
    DrawElementsIndirect: proc "c" (mode: GLenum, gl_type: GLenum, indirect: rawptr),
    DrawElementsInstanced: proc "c" (mode: GLenum, count: GLsizei, gl_type: GLenum, indices: rawptr, instancecount: GLsizei),
    DrawElementsInstancedBaseVertex: proc "c" (mode: GLenum, count: GLsizei, gl_type: GLenum, indices: rawptr, instancecount: GLsizei, basevertex: GLint),
    DrawRangeElements: proc "c" (mode: GLenum, start: GLuint, end: GLuint, count: GLsizei, gl_type: GLenum, indices: rawptr),
    DrawRangeElementsBaseVertex: proc "c" (mode: GLenum, start: GLuint, end: GLuint, count: GLsizei, gl_type: GLenum, indices: rawptr, basevertex: GLint),
    Enable: proc "c" (cap: GLenum),
    EnableVertexAttribArray: proc "c" (index: GLuint),
    Enablei: proc "c" (target: GLenum, index: GLuint),
    EndQuery: proc "c" (target: GLenum),
    EndTransformFeedback: proc "c" (),
    FenceSync: proc "c" (condition: GLenum, flags: GLbitfield) -> GLsync,
    Finish: proc "c" (),
    Flush: proc "c" (),
    FlushMappedBufferRange: proc "c" (target: GLenum, offset: GLintptr, length: GLsizeiptr),
    FramebufferParameteri: proc "c" (target: GLenum, pname: GLenum, param: GLint),
    FramebufferRenderbuffer: proc "c" (target: GLenum, attachment: GLenum, renderbuffertarget: GLenum, renderbuffer: GLuint),
    FramebufferTexture: proc "c" (target: GLenum, attachment: GLenum, texture: GLuint, level: GLint),
    FramebufferTexture2D: proc "c" (target: GLenum, attachment: GLenum, textarget: GLenum, texture: GLuint, level: GLint),
    FramebufferTextureLayer: proc "c" (target: GLenum, attachment: GLenum, texture: GLuint, level: GLint, layer: GLint),
    FrontFace: proc "c" (mode: GLenum),
    GenBuffers: proc "c" (n: GLsizei, buffers: ^GLuint),
    GenFramebuffers: proc "c" (n: GLsizei, framebuffers: ^GLuint),
    GenProgramPipelines: proc "c" (n: GLsizei, pipelines: ^GLuint),
    GenQueries: proc "c" (n: GLsizei, ids: ^GLuint),
    GenRenderbuffers: proc "c" (n: GLsizei, renderbuffers: ^GLuint),
    GenSamplers: proc "c" (count: GLsizei, samplers: ^GLuint),
    GenTextures: proc "c" (n: GLsizei, textures: ^GLuint),
    GenTransformFeedbacks: proc "c" (n: GLsizei, ids: ^GLuint),
    GenVertexArrays: proc "c" (n: GLsizei, arrays: ^GLuint),
    GenerateMipmap: proc "c" (target: GLenum),
    GetActiveAttrib: proc "c" (program: GLuint, index: GLuint, bufSize: GLsizei, length: ^GLsizei, size: ^GLint, gl_type: ^GLenum, name: ^GLchar),
    GetActiveUniform: proc "c" (program: GLuint, index: GLuint, bufSize: GLsizei, length: ^GLsizei, size: ^GLint, gl_type: ^GLenum, name: ^GLchar),
    GetActiveUniformBlockName: proc "c" (program: GLuint, uniformBlockIndex: GLuint, bufSize: GLsizei, length: ^GLsizei, uniformBlockName: ^GLchar),
    GetActiveUniformBlockiv: proc "c" (program: GLuint, uniformBlockIndex: GLuint, pname: GLenum, params: ^GLint),
    GetActiveUniformsiv: proc "c" (program: GLuint, uniformCount: GLsizei, #by_ptr uniformIndices: GLuint, pname: GLenum, params: ^GLint),
    GetAttachedShaders: proc "c" (program: GLuint, maxCount: GLsizei, count: ^GLsizei, shaders: ^GLuint),
    GetAttribLocation: proc "c" (program: GLuint, #by_ptr name: GLchar) -> GLint,
    GetBooleani_v: proc "c" (target: GLenum, index: GLuint, data: ^GLboolean),
    GetBooleanv: proc "c" (pname: GLenum, data: ^GLboolean),
    GetBufferParameteri64v: proc "c" (target: GLenum, pname: GLenum, params: ^GLint64),
    GetBufferParameteriv: proc "c" (target: GLenum, pname: GLenum, params: ^GLint),
    GetBufferPointerv: proc "c" (target: GLenum, pname: GLenum, params: ^rawptr),
    GetDebugMessageLog: proc "c" (count: GLuint, bufSize: GLsizei, sources: ^GLenum, types: ^GLenum, ids: ^GLuint, severities: ^GLenum, lengths: ^GLsizei, messageLog: ^GLchar) -> GLuint,
    GetError: proc "c" () -> GLenum,
    GetFloatv: proc "c" (pname: GLenum, data: ^GLfloat),
    GetFragDataLocation: proc "c" (program: GLuint, #by_ptr name: GLchar) -> GLint,
    GetFramebufferAttachmentParameteriv: proc "c" (target: GLenum, attachment: GLenum, pname: GLenum, params: ^GLint),
    GetFramebufferParameteriv: proc "c" (target: GLenum, pname: GLenum, params: ^GLint),
    GetGraphicsResetStatus: proc "c" () -> GLenum,
    GetInteger64i_v: proc "c" (target: GLenum, index: GLuint, data: ^GLint64),
    GetInteger64v: proc "c" (pname: GLenum, data: ^GLint64),
    GetIntegeri_v: proc "c" (target: GLenum, index: GLuint, data: ^GLint),
    GetIntegerv: proc "c" (pname: GLenum, data: ^GLint),
    GetInternalformativ: proc "c" (target: GLenum, internalformat: GLenum, pname: GLenum, count: GLsizei, params: ^GLint),
    GetMultisamplefv: proc "c" (pname: GLenum, index: GLuint, val: ^GLfloat),
    GetObjectLabel: proc "c" (identifier: GLenum, name: GLuint, bufSize: GLsizei, length: ^GLsizei, label: ^GLchar),
    GetObjectPtrLabel: proc "c" (ptr: rawptr, bufSize: GLsizei, length: ^GLsizei, label: ^GLchar),
    GetPointerv: proc "c" (pname: GLenum, params: ^rawptr),
    GetProgramBinary: proc "c" (program: GLuint, bufSize: GLsizei, length: ^GLsizei, binaryFormat: ^GLenum, binary: ^rawptr),
    GetProgramInfoLog: proc "c" (program: GLuint, bufSize: GLsizei, length: ^GLsizei, infoLog: ^GLchar),
    GetProgramInterfaceiv: proc "c" (program: GLuint, programInterface: GLenum, pname: GLenum, params: ^GLint),
    GetProgramPipelineInfoLog: proc "c" (pipeline: GLuint, bufSize: GLsizei, length: ^GLsizei, infoLog: ^GLchar),
    GetProgramPipelineiv: proc "c" (pipeline: GLuint, pname: GLenum, params: ^GLint),
    GetProgramResourceIndex: proc "c" (program: GLuint, programInterface: GLenum, #by_ptr name: GLchar) -> GLuint,
    GetProgramResourceLocation: proc "c" (program: GLuint, programInterface: GLenum, #by_ptr name: GLchar) -> GLint,
    GetProgramResourceName: proc "c" (program: GLuint, programInterface: GLenum, index: GLuint, bufSize: GLsizei, length: ^GLsizei, name: ^GLchar),
    GetProgramResourceiv: proc "c" (program: GLuint, programInterface: GLenum, index: GLuint, propCount: GLsizei, #by_ptr props: GLenum, count: GLsizei, length: ^GLsizei, params: ^GLint),
    GetProgramiv: proc "c" (program: GLuint, pname: GLenum, params: ^GLint),
    GetQueryObjectuiv: proc "c" (id: GLuint, pname: GLenum, params: ^GLuint),
    GetQueryiv: proc "c" (target: GLenum, pname: GLenum, params: ^GLint),
    GetRenderbufferParameteriv: proc "c" (target: GLenum, pname: GLenum, params: ^GLint),
    GetSamplerParameterIiv: proc "c" (sampler: GLuint, pname: GLenum, params: ^GLint),
    GetSamplerParameterIuiv: proc "c" (sampler: GLuint, pname: GLenum, params: ^GLuint),
    GetSamplerParameterfv: proc "c" (sampler: GLuint, pname: GLenum, params: ^GLfloat),
    GetSamplerParameteriv: proc "c" (sampler: GLuint, pname: GLenum, params: ^GLint),
    GetShaderInfoLog: proc "c" (shader: GLuint, bufSize: GLsizei, length: ^GLsizei, infoLog: ^GLchar),
    GetShaderPrecisionFormat: proc "c" (shadertype: GLenum, precisiontype: GLenum, range: ^GLint, precision: ^GLint),
    GetShaderSource: proc "c" (shader: GLuint, bufSize: GLsizei, length: ^GLsizei, source: ^GLchar),
    GetShaderiv: proc "c" (shader: GLuint, pname: GLenum, params: ^GLint),
    GetString: proc "c" (name: GLenum) -> ^GLubyte,
    GetStringi: proc "c" (name: GLenum, index: GLuint) -> ^GLubyte,
    GetSynciv: proc "c" (sync: GLsync, pname: GLenum, count: GLsizei, length: ^GLsizei, values: ^GLint),
    GetTexLevelParameterfv: proc "c" (target: GLenum, level: GLint, pname: GLenum, params: ^GLfloat),
    GetTexLevelParameteriv: proc "c" (target: GLenum, level: GLint, pname: GLenum, params: ^GLint),
    GetTexParameterIiv: proc "c" (target: GLenum, pname: GLenum, params: ^GLint),
    GetTexParameterIuiv: proc "c" (target: GLenum, pname: GLenum, params: ^GLuint),
    GetTexParameterfv: proc "c" (target: GLenum, pname: GLenum, params: ^GLfloat),
    GetTexParameteriv: proc "c" (target: GLenum, pname: GLenum, params: ^GLint),
    GetTransformFeedbackVarying: proc "c" (program: GLuint, index: GLuint, bufSize: GLsizei, length: ^GLsizei, size: ^GLsizei, gl_type: ^GLenum, name: ^GLchar),
    GetUniformBlockIndex: proc "c" (program: GLuint, #by_ptr uniformBlockName: GLchar) -> GLuint,
    GetUniformIndices: proc "c" (program: GLuint, uniformCount: GLsizei, #by_ptr uniformNames: GLchar, uniformIndices: ^GLuint),
    GetUniformLocation: proc "c" (program: GLuint, name: cstring) -> GLint,
    GetUniformfv: proc "c" (program: GLuint, location: GLint, params: ^GLfloat),
    GetUniformiv: proc "c" (program: GLuint, location: GLint, params: ^GLint),
    GetUniformuiv: proc "c" (program: GLuint, location: GLint, params: ^GLuint),
    GetVertexAttribIiv: proc "c" (index: GLuint, pname: GLenum, params: ^GLint),
    GetVertexAttribIuiv: proc "c" (index: GLuint, pname: GLenum, params: ^GLuint),
    GetVertexAttribPointerv: proc "c" (index: GLuint, pname: GLenum, pointer: ^rawptr),
    GetVertexAttribfv: proc "c" (index: GLuint, pname: GLenum, params: ^GLfloat),
    GetVertexAttribiv: proc "c" (index: GLuint, pname: GLenum, params: ^GLint),
    GetnUniformfv: proc "c" (program: GLuint, location: GLint, bufSize: GLsizei, params: ^GLfloat),
    GetnUniformiv: proc "c" (program: GLuint, location: GLint, bufSize: GLsizei, params: ^GLint),
    GetnUniformuiv: proc "c" (program: GLuint, location: GLint, bufSize: GLsizei, params: ^GLuint),
    Hint: proc "c" (target: GLenum, mode: GLenum),
    InvalidateFramebuffer: proc "c" (target: GLenum, numAttachments: GLsizei, #by_ptr attachments: GLenum),
    InvalidateSubFramebuffer: proc "c" (target: GLenum, numAttachments: GLsizei, #by_ptr attachments: GLenum, x: GLint, y: GLint, width: GLsizei, height: GLsizei),
    IsBuffer: proc "c" (buffer: GLuint) -> GLboolean,
    IsEnabled: proc "c" (cap: GLenum) -> GLboolean,
    IsEnabledi: proc "c" (target: GLenum, index: GLuint) -> GLboolean,
    IsFramebuffer: proc "c" (framebuffer: GLuint) -> GLboolean,
    IsProgram: proc "c" (program: GLuint) -> GLboolean,
    IsProgramPipeline: proc "c" (pipeline: GLuint) -> GLboolean,
    IsQuery: proc "c" (id: GLuint) -> GLboolean,
    IsRenderbuffer: proc "c" (renderbuffer: GLuint) -> GLboolean,
    IsSampler: proc "c" (sampler: GLuint) -> GLboolean,
    IsShader: proc "c" (shader: GLuint) -> GLboolean,
    IsSync: proc "c" (sync: GLsync) -> GLboolean,
    IsTexture: proc "c" (texture: GLuint) -> GLboolean,
    IsTransformFeedback: proc "c" (id: GLuint) -> GLboolean,
    IsVertexArray: proc "c" (array: GLuint) -> GLboolean,
    LineWidth: proc "c" (width: GLfloat),
    LinkProgram: proc "c" (program: GLuint),
    MapBufferRange: proc "c" (target: GLenum, offset: GLintptr, length: GLsizeiptr, access: GLbitfield) -> ^rawptr ,
    MemoryBarrier: proc "c" (barriers: GLbitfield),
    MemoryBarrierByRegion: proc "c" (barriers: GLbitfield),
    MinSampleShading: proc "c" (value: GLfloat),
    ObjectLabel: proc "c" (identifier: GLenum, name: GLuint, length: GLsizei, #by_ptr label: GLchar),
    ObjectPtrLabel: proc "c" (ptr: rawptr, length: GLsizei, #by_ptr label: GLchar),
    PatchParameteri: proc "c" (pname: GLenum, value: GLint),
    PauseTransformFeedback: proc "c" (),
    PixelStorei: proc "c" (pname: GLenum, param: GLint),
    PolygonOffset: proc "c" (factor: GLfloat, units: GLfloat),
    PopDebugGroup: proc "c" (),
    PrimitiveBoundingBox: proc "c" (minX: GLfloat, minY: GLfloat, minZ: GLfloat, minW: GLfloat, maxX: GLfloat, maxY: GLfloat, maxZ: GLfloat, maxW: GLfloat),
    ProgramBinary: proc "c" (program: GLuint, binaryFormat: GLenum, binary: rawptr, length: GLsizei),
    ProgramParameteri: proc "c" (program: GLuint, pname: GLenum, value: GLint),
    ProgramUniform1f: proc "c" (program: GLuint, location: GLint, v0: GLfloat),
    ProgramUniform1fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLfloat),
    ProgramUniform1i: proc "c" (program: GLuint, location: GLint, v0: GLint),
    ProgramUniform1iv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLint),
    ProgramUniform1ui: proc "c" (program: GLuint, location: GLint, v0: GLuint),
    ProgramUniform1uiv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLuint),
    ProgramUniform2f: proc "c" (program: GLuint, location: GLint, v0: GLfloat, v1: GLfloat),
    ProgramUniform2fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLfloat),
    ProgramUniform2i: proc "c" (program: GLuint, location: GLint, v0: GLint, v1: GLint),
    ProgramUniform2iv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLint),
    ProgramUniform2ui: proc "c" (program: GLuint, location: GLint, v0: GLuint, v1: GLuint),
    ProgramUniform2uiv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLuint),
    ProgramUniform3f: proc "c" (program: GLuint, location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat),
    ProgramUniform3fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLfloat),
    ProgramUniform3i: proc "c" (program: GLuint, location: GLint, v0: GLint, v1: GLint, v2: GLint),
    ProgramUniform3iv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLint),
    ProgramUniform3ui: proc "c" (program: GLuint, location: GLint, v0: GLuint, v1: GLuint, v2: GLuint),
    ProgramUniform3uiv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLuint),
    ProgramUniform4f: proc "c" (program: GLuint, location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat, v3: GLfloat),
    ProgramUniform4fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLfloat),
    ProgramUniform4i: proc "c" (program: GLuint, location: GLint, v0: GLint, v1: GLint, v2: GLint, v3: GLint),
    ProgramUniform4iv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLint),
    ProgramUniform4ui: proc "c" (program: GLuint, location: GLint, v0: GLuint, v1: GLuint, v2: GLuint, v3: GLuint),
    ProgramUniform4uiv: proc "c" (program: GLuint, location: GLint, count: GLsizei, #by_ptr value: GLuint),
    ProgramUniformMatrix2fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    ProgramUniformMatrix2x3fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    ProgramUniformMatrix2x4fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    ProgramUniformMatrix3fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    ProgramUniformMatrix3x2fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    ProgramUniformMatrix3x4fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    ProgramUniformMatrix4fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    ProgramUniformMatrix4x2fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    ProgramUniformMatrix4x3fv: proc "c" (program: GLuint, location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    PushDebugGroup: proc "c" (source: GLenum, id: GLuint, length: GLsizei, #by_ptr message: GLchar),
    ReadBuffer: proc "c" (src: GLenum),
    ReadPixels: proc "c" (x: GLint, y: GLint, width: GLsizei, height: GLsizei, format: GLenum, gl_type: GLenum, pixels: ^rawptr),
    ReadnPixels: proc "c" (x: GLint, y: GLint, width: GLsizei, height: GLsizei, format: GLenum, gl_type: GLenum, bufSize: GLsizei, data: ^rawptr),
    ReleaseShaderCompiler: proc "c" (),
    RenderbufferStorage: proc "c" (target: GLenum, internalformat: GLenum, width: GLsizei, height: GLsizei),
    RenderbufferStorageMultisample: proc "c" (target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei),
    ResumeTransformFeedback: proc "c" (),
    SampleCoverage: proc "c" (value: GLfloat, invert: GLboolean),
    SampleMaski: proc "c" (maskNumber: GLuint, mask: GLbitfield),
    SamplerParameterIiv: proc "c" (sampler: GLuint, pname: GLenum, #by_ptr param: GLint),
    SamplerParameterIuiv: proc "c" (sampler: GLuint, pname: GLenum, #by_ptr param: GLuint),
    SamplerParameterf: proc "c" (sampler: GLuint, pname: GLenum, param: GLfloat),
    SamplerParameterfv: proc "c" (sampler: GLuint, pname: GLenum, #by_ptr param: GLfloat),
    SamplerParameteri: proc "c" (sampler: GLuint, pname: GLenum, param: GLint),
    SamplerParameteriv: proc "c" (sampler: GLuint, pname: GLenum, #by_ptr param: GLint),
    Scissor: proc "c" (x: GLint, y: GLint, width: GLsizei, height: GLsizei),
    ShaderBinary: proc "c" (count: GLsizei, #by_ptr shaders: GLuint, binaryFormat: GLenum, binary: rawptr, length: GLsizei),
    ShaderSource: proc "c" (shader: GLuint, count: GLsizei, string: ^cstring, #by_ptr length: GLint),
    StencilFunc: proc "c" (func: GLenum, ref: GLint, mask: GLuint),
    StencilFuncSeparate: proc "c" (face: GLenum, func: GLenum, ref: GLint, mask: GLuint),
    StencilMask: proc "c" (mask: GLuint),
    StencilMaskSeparate: proc "c" (face: GLenum, mask: GLuint),
    StencilOp: proc "c" (fail: GLenum, zfail: GLenum, zpass: GLenum),
    StencilOpSeparate: proc "c" (face: GLenum, sfail: GLenum, dpfail: GLenum, dppass: GLenum),
    TexBuffer: proc "c" (target: GLenum, internalformat: GLenum, buffer: GLuint),
    TexBufferRange: proc "c" (target: GLenum, internalformat: GLenum, buffer: GLuint, offset: GLintptr, size: GLsizeiptr),
    TexImage2D: proc "c" (target: GLenum, level: GLint, internalformat: GLint, width: GLsizei, height: GLsizei, border: GLint, format: GLenum, gl_type: GLenum, pixels: rawptr),
    TexImage3D: proc "c" (target: GLenum, level: GLint, internalformat: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, border: GLint, format: GLenum, gl_type: GLenum, pixels: rawptr),
    TexParameterIiv: proc "c" (target: GLenum, pname: GLenum, #by_ptr params: GLint),
    TexParameterIuiv: proc "c" (target: GLenum, pname: GLenum, #by_ptr params: GLuint),
    TexParameterf: proc "c" (target: GLenum, pname: GLenum, param: GLfloat),
    TexParameterfv: proc "c" (target: GLenum, pname: GLenum, #by_ptr params: GLfloat),
    TexParameteri: proc "c" (target: GLenum, pname: GLenum, param: GLint),
    TexParameteriv: proc "c" (target: GLenum, pname: GLenum, #by_ptr params: GLint),
    TexStorage2D: proc "c" (target: GLenum, levels: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei),
    TexStorage2DMultisample: proc "c" (target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei, fixedsamplelocations: GLboolean),
    TexStorage3D: proc "c" (target: GLenum, levels: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei, depth: GLsizei),
    TexStorage3DMultisample: proc "c" (target: GLenum, samples: GLsizei, internalformat: GLenum, width: GLsizei, height: GLsizei, depth: GLsizei, fixedsamplelocations: GLboolean),
    TexSubImage2D: proc "c" (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, width: GLsizei, height: GLsizei, format: GLenum, gl_type: GLenum, pixels: rawptr),
    TexSubImage3D: proc "c" (target: GLenum, level: GLint, xoffset: GLint, yoffset: GLint, zoffset: GLint, width: GLsizei, height: GLsizei, depth: GLsizei, format: GLenum, gl_type: GLenum, pixels: rawptr),
    TransformFeedbackVaryings: proc "c" (program: GLuint, count: GLsizei, #by_ptr varyings: GLchar, bufferMode: GLenum),
    Uniform1f: proc "c" (location: GLint, v0: GLfloat),
    Uniform1fv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLfloat),
    Uniform1i: proc "c" (location: GLint, v0: GLint),
    Uniform1iv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLint),
    Uniform1ui: proc "c" (location: GLint, v0: GLuint),
    Uniform1uiv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLuint),
    Uniform2f: proc "c" (location: GLint, v0: GLfloat, v1: GLfloat),
    Uniform2fv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLfloat),
    Uniform2i: proc "c" (location: GLint, v0: GLint, v1: GLint),
    Uniform2iv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLint),
    Uniform2ui: proc "c" (location: GLint, v0: GLuint, v1: GLuint),
    Uniform2uiv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLuint),
    Uniform3f: proc "c" (location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat),
    Uniform3fv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLfloat),
    Uniform3i: proc "c" (location: GLint, v0: GLint, v1: GLint, v2: GLint),
    Uniform3iv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLint),
    Uniform3ui: proc "c" (location: GLint, v0: GLuint, v1: GLuint, v2: GLuint),
    Uniform3uiv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLuint),
    Uniform4f: proc "c" (location: GLint, v0: GLfloat, v1: GLfloat, v2: GLfloat, v3: GLfloat),
    Uniform4fv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLfloat),
    Uniform4i: proc "c" (location: GLint, v0: GLint, v1: GLint, v2: GLint, v3: GLint),
    Uniform4iv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLint),
    Uniform4ui: proc "c" (location: GLint, v0: GLuint, v1: GLuint, v2: GLuint, v3: GLuint),
    Uniform4uiv: proc "c" (location: GLint, count: GLsizei, #by_ptr value: GLuint),
    UniformBlockBinding: proc "c" (program: GLuint, uniformBlockIndex: GLuint, uniformBlockBinding: GLuint),
    UniformMatrix2fv: proc "c" (location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    UniformMatrix2x3fv: proc "c" (location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    UniformMatrix2x4fv: proc "c" (location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    UniformMatrix3fv: proc "c" (location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    UniformMatrix3x2fv: proc "c" (location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    UniformMatrix3x4fv: proc "c" (location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    UniformMatrix4fv: proc "c" (location: GLint, count: GLsizei, transpose: GLboolean, value: ^GLfloat),
    UniformMatrix4x2fv: proc "c" (location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    UniformMatrix4x3fv: proc "c" (location: GLint, count: GLsizei, transpose: GLboolean, #by_ptr value: GLfloat),
    UnmapBuffer: proc "c" (target: GLenum) -> GLboolean,
    UseProgram: proc "c" (program: GLuint),
    UseProgramStages: proc "c" (pipeline: GLuint, stages: GLbitfield, program: GLuint),
    ValidateProgram: proc "c" (program: GLuint),
    ValidateProgramPipeline: proc "c" (pipeline: GLuint),
    VertexAttrib1f: proc "c" (index: GLuint, x: GLfloat),
    VertexAttrib1fv: proc "c" (index: GLuint, #by_ptr v: GLfloat),
    VertexAttrib2f: proc "c" (index: GLuint, x: GLfloat, y: GLfloat),
    VertexAttrib2fv: proc "c" (index: GLuint, #by_ptr v: GLfloat),
    VertexAttrib3f: proc "c" (index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat),
    VertexAttrib3fv: proc "c" (index: GLuint, #by_ptr v: GLfloat),
    VertexAttrib4f: proc "c" (index: GLuint, x: GLfloat, y: GLfloat, z: GLfloat, w: GLfloat),
    VertexAttrib4fv: proc "c" (index: GLuint, #by_ptr v: GLfloat),
    VertexAttribBinding: proc "c" (attribindex: GLuint, bindingindex: GLuint),
    VertexAttribDivisor: proc "c" (index: GLuint, divisor: GLuint),
    VertexAttribFormat: proc "c" (attribindex: GLuint, size: GLint, gl_type: GLenum, normalized: GLboolean, relativeoffset: GLuint),
    VertexAttribI4i: proc "c" (index: GLuint, x: GLint, y: GLint, z: GLint, w: GLint),
    VertexAttribI4iv: proc "c" (index: GLuint, #by_ptr v: GLint),
    VertexAttribI4ui: proc "c" (index: GLuint, x: GLuint, y: GLuint, z: GLuint, w: GLuint),
    VertexAttribI4uiv: proc "c" (index: GLuint, #by_ptr v: GLuint),
    VertexAttribIFormat: proc "c" (attribindex: GLuint, size: GLint, gl_type: GLenum, relativeoffset: GLuint),
    VertexAttribIPointer: proc "c" (index: GLuint, size: GLint, gl_type: GLenum, stride: GLsizei, pointer: rawptr),
    VertexAttribPointer: proc "c" (index: GLuint, size: GLint, gl_type: GLenum, normalized: GLboolean, stride: GLsizei, pointer: rawptr),
    VertexBindingDivisor: proc "c" (bindingindex: GLuint, divisor: GLuint),
    Viewport: proc "c" (x: GLint, y: GLint, width: GLsizei, height: GLsizei),
    WaitSync: proc "c" (sync: GLsync, flags: GLbitfield, timeout: GLuint64),
}

GLuint :: c.uint
GLint :: c.int
GLenum :: c.uint
GLchar :: c.char
GLintptr :: c.intptr_t
GLboolean :: c.uchar
GLsizeiptr :: c.ssize_t
GLsizei :: c.int
GLfloat :: c.float
GLbitfield :: c.uint
GLuint64 :: c.uint64_t
GLint64 :: c.int64_t
GLsync :: rawptr
GLubyte :: c.uint8_t

DebugProc :: proc "c" (source: GLenum, type: GLenum, id: GLuint, severity: GLenum, length: GLsizei, message: cstring, userParam: rawptr)

ACTIVE_ATOMIC_COUNTER_BUFFERS :: 0x92D9
ACTIVE_ATTRIBUTES :: 0x8B89
ACTIVE_ATTRIBUTE_MAX_LENGTH :: 0x8B8A
ACTIVE_PROGRAM :: 0x8259
ACTIVE_RESOURCES :: 0x92F5
ACTIVE_TEXTURE :: 0x84E0
ACTIVE_UNIFORMS :: 0x8B86
ACTIVE_UNIFORM_BLOCKS :: 0x8A36
ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH :: 0x8A35
ACTIVE_UNIFORM_MAX_LENGTH :: 0x8B87
ACTIVE_VARIABLES :: 0x9305
ALIASED_LINE_WIDTH_RANGE :: 0x846E
ALIASED_POINT_SIZE_RANGE :: 0x846D
ALL_BARRIER_BITS :: 0xFFFFFFFF
ALL_SHADER_BITS :: 0xFFFFFFFF
ALPHA :: 0x1906
ALPHA_BITS :: 0x0D55
ALREADY_SIGNALED :: 0x911A
ALWAYS :: 0x0207
ANY_SAMPLES_PASSED :: 0x8C2F
ANY_SAMPLES_PASSED_CONSERVATIVE :: 0x8D6A
ARRAY_BUFFER :: 0x8892
ARRAY_BUFFER_BINDING :: 0x8894
ARRAY_SIZE :: 0x92FB
ARRAY_STRIDE :: 0x92FE
ATOMIC_COUNTER_BARRIER_BIT :: 0x00001000
ATOMIC_COUNTER_BUFFER :: 0x92C0
ATOMIC_COUNTER_BUFFER_BINDING :: 0x92C1
ATOMIC_COUNTER_BUFFER_INDEX :: 0x9301
ATOMIC_COUNTER_BUFFER_SIZE :: 0x92C3
ATOMIC_COUNTER_BUFFER_START :: 0x92C2
ATTACHED_SHADERS :: 0x8B85
BACK :: 0x0405
BLEND :: 0x0BE2
BLEND_COLOR :: 0x8005
BLEND_DST_ALPHA :: 0x80CA
BLEND_DST_RGB :: 0x80C8
BLEND_EQUATION :: 0x8009
BLEND_EQUATION_ALPHA :: 0x883D
BLEND_EQUATION_RGB :: 0x8009
BLEND_SRC_ALPHA :: 0x80CB
BLEND_SRC_RGB :: 0x80C9
BLOCK_INDEX :: 0x92FD
BLUE :: 0x1905
BLUE_BITS :: 0x0D54
BOOL :: 0x8B56
BOOL_VEC2 :: 0x8B57
BOOL_VEC3 :: 0x8B58
BOOL_VEC4 :: 0x8B59
BUFFER :: 0x82E0
BUFFER_ACCESS_FLAGS :: 0x911F
BUFFER_BINDING :: 0x9302
BUFFER_DATA_SIZE :: 0x9303
BUFFER_MAPPED :: 0x88BC
BUFFER_MAP_LENGTH :: 0x9120
BUFFER_MAP_OFFSET :: 0x9121
BUFFER_MAP_POINTER :: 0x88BD
BUFFER_SIZE :: 0x8764
BUFFER_UPDATE_BARRIER_BIT :: 0x00000200
BUFFER_USAGE :: 0x8765
BUFFER_VARIABLE :: 0x92E5
BYTE :: 0x1400
CCW :: 0x0901
CLAMP_TO_BORDER :: 0x812D
CLAMP_TO_EDGE :: 0x812F
COLOR :: 0x1800
COLORBURN :: 0x929A
COLORDODGE :: 0x9299
COLOR_ATTACHMENT0 :: 0x8CE0
COLOR_ATTACHMENT1 :: 0x8CE1
COLOR_ATTACHMENT10 :: 0x8CEA
COLOR_ATTACHMENT11 :: 0x8CEB
COLOR_ATTACHMENT12 :: 0x8CEC
COLOR_ATTACHMENT13 :: 0x8CED
COLOR_ATTACHMENT14 :: 0x8CEE
COLOR_ATTACHMENT15 :: 0x8CEF
COLOR_ATTACHMENT16 :: 0x8CF0
COLOR_ATTACHMENT17 :: 0x8CF1
COLOR_ATTACHMENT18 :: 0x8CF2
COLOR_ATTACHMENT19 :: 0x8CF3
COLOR_ATTACHMENT2 :: 0x8CE2
COLOR_ATTACHMENT20 :: 0x8CF4
COLOR_ATTACHMENT21 :: 0x8CF5
COLOR_ATTACHMENT22 :: 0x8CF6
COLOR_ATTACHMENT23 :: 0x8CF7
COLOR_ATTACHMENT24 :: 0x8CF8
COLOR_ATTACHMENT25 :: 0x8CF9
COLOR_ATTACHMENT26 :: 0x8CFA
COLOR_ATTACHMENT27 :: 0x8CFB
COLOR_ATTACHMENT28 :: 0x8CFC
COLOR_ATTACHMENT29 :: 0x8CFD
COLOR_ATTACHMENT3 :: 0x8CE3
COLOR_ATTACHMENT30 :: 0x8CFE
COLOR_ATTACHMENT31 :: 0x8CFF
COLOR_ATTACHMENT4 :: 0x8CE4
COLOR_ATTACHMENT5 :: 0x8CE5
COLOR_ATTACHMENT6 :: 0x8CE6
COLOR_ATTACHMENT7 :: 0x8CE7
COLOR_ATTACHMENT8 :: 0x8CE8
COLOR_ATTACHMENT9 :: 0x8CE9
COLOR_BUFFER_BIT :: 0x00004000
COLOR_CLEAR_VALUE :: 0x0C22
COLOR_WRITEMASK :: 0x0C23
COMMAND_BARRIER_BIT :: 0x00000040
COMPARE_REF_TO_TEXTURE :: 0x884E
COMPARE_R_TO_TEXTURE :: 0x884E
COMPILE_STATUS :: 0x8B81
COMPRESSED_R11_EAC :: 0x9270
COMPRESSED_RG11_EAC :: 0x9272
COMPRESSED_RGB8_ETC2 :: 0x9274
COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2 :: 0x9276
COMPRESSED_RGBA8_ETC2_EAC :: 0x9278
COMPRESSED_RGBA_ASTC_10x10 :: 0x93BB
COMPRESSED_RGBA_ASTC_10x5 :: 0x93B8
COMPRESSED_RGBA_ASTC_10x6 :: 0x93B9
COMPRESSED_RGBA_ASTC_10x8 :: 0x93BA
COMPRESSED_RGBA_ASTC_12x10 :: 0x93BC
COMPRESSED_RGBA_ASTC_12x12 :: 0x93BD
COMPRESSED_RGBA_ASTC_4x4 :: 0x93B0
COMPRESSED_RGBA_ASTC_5x4 :: 0x93B1
COMPRESSED_RGBA_ASTC_5x5 :: 0x93B2
COMPRESSED_RGBA_ASTC_6x5 :: 0x93B3
COMPRESSED_RGBA_ASTC_6x6 :: 0x93B4
COMPRESSED_RGBA_ASTC_8x5 :: 0x93B5
COMPRESSED_RGBA_ASTC_8x6 :: 0x93B6
COMPRESSED_RGBA_ASTC_8x8 :: 0x93B7
COMPRESSED_SIGNED_R11_EAC :: 0x9271
COMPRESSED_SIGNED_RG11_EAC :: 0x9273
COMPRESSED_SRGB8_ALPHA8_ASTC_10x10 :: 0x93DB
COMPRESSED_SRGB8_ALPHA8_ASTC_10x5 :: 0x93D8
COMPRESSED_SRGB8_ALPHA8_ASTC_10x6 :: 0x93D9
COMPRESSED_SRGB8_ALPHA8_ASTC_10x8 :: 0x93DA
COMPRESSED_SRGB8_ALPHA8_ASTC_12x10 :: 0x93DC
COMPRESSED_SRGB8_ALPHA8_ASTC_12x12 :: 0x93DD
COMPRESSED_SRGB8_ALPHA8_ASTC_4x4 :: 0x93D0
COMPRESSED_SRGB8_ALPHA8_ASTC_5x4 :: 0x93D1
COMPRESSED_SRGB8_ALPHA8_ASTC_5x5 :: 0x93D2
COMPRESSED_SRGB8_ALPHA8_ASTC_6x5 :: 0x93D3
COMPRESSED_SRGB8_ALPHA8_ASTC_6x6 :: 0x93D4
COMPRESSED_SRGB8_ALPHA8_ASTC_8x5 :: 0x93D5
COMPRESSED_SRGB8_ALPHA8_ASTC_8x6 :: 0x93D6
COMPRESSED_SRGB8_ALPHA8_ASTC_8x8 :: 0x93D7
COMPRESSED_SRGB8_ALPHA8_ETC2_EAC :: 0x9279
COMPRESSED_SRGB8_ETC2 :: 0x9275
COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2 :: 0x9277
COMPRESSED_TEXTURE_FORMATS :: 0x86A3
COMPUTE_SHADER :: 0x91B9
COMPUTE_SHADER_BIT :: 0x00000020
COMPUTE_WORK_GROUP_SIZE :: 0x8267
CONDITION_SATISFIED :: 0x911C
CONSTANT_ALPHA :: 0x8003
CONSTANT_COLOR :: 0x8001
CONTEXT_FLAGS :: 0x821E
CONTEXT_FLAG_DEBUG_BIT :: 0x00000002
CONTEXT_FLAG_ROBUST_ACCESS_BIT :: 0x00000004
CONTEXT_LOST :: 0x0507
COPY_READ_BUFFER :: 0x8F36
COPY_READ_BUFFER_BINDING :: 0x8F36
COPY_WRITE_BUFFER :: 0x8F37
COPY_WRITE_BUFFER_BINDING :: 0x8F37
CULL_FACE :: 0x0B44
CULL_FACE_MODE :: 0x0B45
CURRENT_PROGRAM :: 0x8B8D
CURRENT_QUERY :: 0x8865
CURRENT_VERTEX_ATTRIB :: 0x8626
CW :: 0x0900
DARKEN :: 0x9297
DEBUG_CALLBACK_FUNCTION :: 0x8244
DEBUG_CALLBACK_USER_PARAM :: 0x8245
DEBUG_GROUP_STACK_DEPTH :: 0x826D
DEBUG_LOGGED_MESSAGES :: 0x9145
DEBUG_NEXT_LOGGED_MESSAGE_LENGTH :: 0x8243
DEBUG_OUTPUT :: 0x92E0
DEBUG_OUTPUT_SYNCHRONOUS :: 0x8242
DEBUG_SEVERITY_HIGH :: 0x9146
DEBUG_SEVERITY_LOW :: 0x9148
DEBUG_SEVERITY_MEDIUM :: 0x9147
DEBUG_SEVERITY_NOTIFICATION :: 0x826B
DEBUG_SOURCE_API :: 0x8246
DEBUG_SOURCE_APPLICATION :: 0x824A
DEBUG_SOURCE_OTHER :: 0x824B
DEBUG_SOURCE_SHADER_COMPILER :: 0x8248
DEBUG_SOURCE_THIRD_PARTY :: 0x8249
DEBUG_SOURCE_WINDOW_SYSTEM :: 0x8247
DEBUG_TYPE_DEPRECATED_BEHAVIOR :: 0x824D
DEBUG_TYPE_ERROR :: 0x824C
DEBUG_TYPE_MARKER :: 0x8268
DEBUG_TYPE_OTHER :: 0x8251
DEBUG_TYPE_PERFORMANCE :: 0x8250
DEBUG_TYPE_POP_GROUP :: 0x826A
DEBUG_TYPE_PORTABILITY :: 0x824F
DEBUG_TYPE_PUSH_GROUP :: 0x8269
DEBUG_TYPE_UNDEFINED_BEHAVIOR :: 0x824E
DECR :: 0x1E03
DECR_WRAP :: 0x8508
DELETE_STATUS :: 0x8B80
DEPTH :: 0x1801
DEPTH24_STENCIL8 :: 0x88F0
DEPTH32F_STENCIL8 :: 0x8CAD
DEPTH_ATTACHMENT :: 0x8D00
DEPTH_BITS :: 0x0D56
DEPTH_BUFFER_BIT :: 0x00000100
DEPTH_CLEAR_VALUE :: 0x0B73
DEPTH_COMPONENT :: 0x1902
DEPTH_COMPONENT16 :: 0x81A5
DEPTH_COMPONENT24 :: 0x81A6
DEPTH_COMPONENT32F :: 0x8CAC
DEPTH_FUNC :: 0x0B74
DEPTH_RANGE :: 0x0B70
DEPTH_STENCIL :: 0x84F9
DEPTH_STENCIL_ATTACHMENT :: 0x821A
DEPTH_STENCIL_TEXTURE_MODE :: 0x90EA
DEPTH_TEST :: 0x0B71
DEPTH_WRITEMASK :: 0x0B72
DIFFERENCE :: 0x929E
DISPATCH_INDIRECT_BUFFER :: 0x90EE
DISPATCH_INDIRECT_BUFFER_BINDING :: 0x90EF
DITHER :: 0x0BD0
DONT_CARE :: 0x1100
DRAW_BUFFER0 :: 0x8825
DRAW_BUFFER1 :: 0x8826
DRAW_BUFFER10 :: 0x882F
DRAW_BUFFER11 :: 0x8830
DRAW_BUFFER12 :: 0x8831
DRAW_BUFFER13 :: 0x8832
DRAW_BUFFER14 :: 0x8833
DRAW_BUFFER15 :: 0x8834
DRAW_BUFFER2 :: 0x8827
DRAW_BUFFER3 :: 0x8828
DRAW_BUFFER4 :: 0x8829
DRAW_BUFFER5 :: 0x882A
DRAW_BUFFER6 :: 0x882B
DRAW_BUFFER7 :: 0x882C
DRAW_BUFFER8 :: 0x882D
DRAW_BUFFER9 :: 0x882E
DRAW_FRAMEBUFFER :: 0x8CA9
DRAW_FRAMEBUFFER_BINDING :: 0x8CA6
DRAW_INDIRECT_BUFFER :: 0x8F3F
DRAW_INDIRECT_BUFFER_BINDING :: 0x8F43
DST_ALPHA :: 0x0304
DST_COLOR :: 0x0306
DYNAMIC_COPY :: 0x88EA
DYNAMIC_DRAW :: 0x88E8
DYNAMIC_READ :: 0x88E9
ELEMENT_ARRAY_BARRIER_BIT :: 0x00000002
ELEMENT_ARRAY_BUFFER :: 0x8893
ELEMENT_ARRAY_BUFFER_BINDING :: 0x8895
EQUAL :: 0x0202
EXCLUSION :: 0x92A0
EXTENSIONS :: 0x1F03
FALSE :: 0
FASTEST :: 0x1101
FIRST_VERTEX_CONVENTION :: 0x8E4D
FIXED :: 0x140C
FLOAT :: 0x1406
FLOAT_32_UNSIGNED_INT_24_8_REV :: 0x8DAD
FLOAT_MAT2 :: 0x8B5A
FLOAT_MAT2x3 :: 0x8B65
FLOAT_MAT2x4 :: 0x8B66
FLOAT_MAT3 :: 0x8B5B
FLOAT_MAT3x2 :: 0x8B67
FLOAT_MAT3x4 :: 0x8B68
FLOAT_MAT4 :: 0x8B5C
FLOAT_MAT4x2 :: 0x8B69
FLOAT_MAT4x3 :: 0x8B6A
FLOAT_VEC2 :: 0x8B50
FLOAT_VEC3 :: 0x8B51
FLOAT_VEC4 :: 0x8B52
FRACTIONAL_EVEN :: 0x8E7C
FRACTIONAL_ODD :: 0x8E7B
FRAGMENT_INTERPOLATION_OFFSET_BITS :: 0x8E5D
FRAGMENT_SHADER :: 0x8B30
FRAGMENT_SHADER_BIT :: 0x00000002
FRAGMENT_SHADER_DERIVATIVE_HINT :: 0x8B8B
FRAMEBUFFER :: 0x8D40
FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE :: 0x8215
FRAMEBUFFER_ATTACHMENT_BLUE_SIZE :: 0x8214
FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING :: 0x8210
FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE :: 0x8211
FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE :: 0x8216
FRAMEBUFFER_ATTACHMENT_GREEN_SIZE :: 0x8213
FRAMEBUFFER_ATTACHMENT_LAYERED :: 0x8DA7
FRAMEBUFFER_ATTACHMENT_OBJECT_NAME :: 0x8CD1
FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE :: 0x8CD0
FRAMEBUFFER_ATTACHMENT_RED_SIZE :: 0x8212
FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE :: 0x8217
FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE :: 0x8CD3
FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER :: 0x8CD4
FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL :: 0x8CD2
FRAMEBUFFER_BARRIER_BIT :: 0x00000400
FRAMEBUFFER_BINDING :: 0x8CA6
FRAMEBUFFER_COMPLETE :: 0x8CD5
FRAMEBUFFER_DEFAULT :: 0x8218
FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS :: 0x9314
FRAMEBUFFER_DEFAULT_HEIGHT :: 0x9311
FRAMEBUFFER_DEFAULT_LAYERS :: 0x9312
FRAMEBUFFER_DEFAULT_SAMPLES :: 0x9313
FRAMEBUFFER_DEFAULT_WIDTH :: 0x9310
FRAMEBUFFER_INCOMPLETE_ATTACHMENT :: 0x8CD6
FRAMEBUFFER_INCOMPLETE_DIMENSIONS :: 0x8CD9
FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS :: 0x8DA8
FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT :: 0x8CD7
FRAMEBUFFER_INCOMPLETE_MULTISAMPLE :: 0x8D56
FRAMEBUFFER_UNDEFINED :: 0x8219
FRAMEBUFFER_UNSUPPORTED :: 0x8CDD
FRONT :: 0x0404
FRONT_AND_BACK :: 0x0408
FRONT_FACE :: 0x0B46
FUNC_ADD :: 0x8006
FUNC_REVERSE_SUBTRACT :: 0x800B
FUNC_SUBTRACT :: 0x800A
GENERATE_MIPMAP_HINT :: 0x8192
GEOMETRY_INPUT_TYPE :: 0x8917
GEOMETRY_OUTPUT_TYPE :: 0x8918
GEOMETRY_SHADER :: 0x8DD9
GEOMETRY_SHADER_BIT :: 0x00000004
GEOMETRY_SHADER_INVOCATIONS :: 0x887F
GEOMETRY_VERTICES_OUT :: 0x8916
GEQUAL :: 0x0206
GREATER :: 0x0204
GREEN :: 0x1904
GREEN_BITS :: 0x0D53
GUILTY_CONTEXT_RESET :: 0x8253
HALF_FLOAT :: 0x140B
HARDLIGHT :: 0x929B
HIGH_FLOAT :: 0x8DF2
HIGH_INT :: 0x8DF5
HSL_COLOR :: 0x92AF
HSL_HUE :: 0x92AD
HSL_LUMINOSITY :: 0x92B0
HSL_SATURATION :: 0x92AE
IMAGE_2D :: 0x904D
IMAGE_2D_ARRAY :: 0x9053
IMAGE_3D :: 0x904E
IMAGE_BINDING_ACCESS :: 0x8F3E
IMAGE_BINDING_FORMAT :: 0x906E
IMAGE_BINDING_LAYER :: 0x8F3D
IMAGE_BINDING_LAYERED :: 0x8F3C
IMAGE_BINDING_LEVEL :: 0x8F3B
IMAGE_BINDING_NAME :: 0x8F3A
IMAGE_BUFFER :: 0x9051
IMAGE_CUBE :: 0x9050
IMAGE_CUBE_MAP_ARRAY :: 0x9054
IMAGE_FORMAT_COMPATIBILITY_BY_CLASS :: 0x90C9
IMAGE_FORMAT_COMPATIBILITY_BY_SIZE :: 0x90C8
IMAGE_FORMAT_COMPATIBILITY_TYPE :: 0x90C7
IMPLEMENTATION_COLOR_READ_FORMAT :: 0x8B9B
IMPLEMENTATION_COLOR_READ_TYPE :: 0x8B9A
INCR :: 0x1E02
INCR_WRAP :: 0x8507
INFO_LOG_LENGTH :: 0x8B84
INNOCENT_CONTEXT_RESET :: 0x8254
INT :: 0x1404
INTERLEAVED_ATTRIBS :: 0x8C8C
INT_2_10_10_10_REV :: 0x8D9F
INT_IMAGE_2D :: 0x9058
INT_IMAGE_2D_ARRAY :: 0x905E
INT_IMAGE_3D :: 0x9059
INT_IMAGE_BUFFER :: 0x905C
INT_IMAGE_CUBE :: 0x905B
INT_IMAGE_CUBE_MAP_ARRAY :: 0x905F
INT_SAMPLER_2D :: 0x8DCA
INT_SAMPLER_2D_ARRAY :: 0x8DCF
INT_SAMPLER_2D_MULTISAMPLE :: 0x9109
INT_SAMPLER_2D_MULTISAMPLE_ARRAY :: 0x910C
INT_SAMPLER_3D :: 0x8DCB
INT_SAMPLER_BUFFER :: 0x8DD0
INT_SAMPLER_CUBE :: 0x8DCC
INT_SAMPLER_CUBE_MAP_ARRAY :: 0x900E
INT_VEC2 :: 0x8B53
INT_VEC3 :: 0x8B54
INT_VEC4 :: 0x8B55
INVALID_ENUM :: 0x0500
INVALID_FRAMEBUFFER_OPERATION :: 0x0506
INVALID_INDEX :: 0xFFFFFFFF
INVALID_OPERATION :: 0x0502
INVALID_VALUE :: 0x0501
INVERT :: 0x150A
ISOLINES :: 0x8E7A
IS_PER_PATCH :: 0x92E7
IS_ROW_MAJOR :: 0x9300
KEEP :: 0x1E00
LAST_VERTEX_CONVENTION :: 0x8E4E
LAYER_PROVOKING_VERTEX :: 0x825E
LEQUAL :: 0x0203
LESS :: 0x0201
LIGHTEN :: 0x9298
LINEAR :: 0x2601
LINEAR_MIPMAP_LINEAR :: 0x2703
LINEAR_MIPMAP_NEAREST :: 0x2701
LINES :: 0x0001
LINES_ADJACENCY :: 0x000A
LINE_LOOP :: 0x0002
LINE_STRIP :: 0x0003
LINE_STRIP_ADJACENCY :: 0x000B
LINE_WIDTH :: 0x0B21
LINK_STATUS :: 0x8B82
LOCATION :: 0x930E
LOSE_CONTEXT_ON_RESET :: 0x8252
LOW_FLOAT :: 0x8DF0
LOW_INT :: 0x8DF3
LUMINANCE :: 0x1909
LUMINANCE_ALPHA :: 0x190A
MAJOR_VERSION :: 0x821B
MAP_FLUSH_EXPLICIT_BIT :: 0x0010
MAP_INVALIDATE_BUFFER_BIT :: 0x0008
MAP_INVALIDATE_RANGE_BIT :: 0x0004
MAP_READ_BIT :: 0x0001
MAP_UNSYNCHRONIZED_BIT :: 0x0020
MAP_WRITE_BIT :: 0x0002
MATRIX_STRIDE :: 0x92FF
MAX :: 0x8008
MAX_3D_TEXTURE_SIZE :: 0x8073
MAX_ARRAY_TEXTURE_LAYERS :: 0x88FF
MAX_ATOMIC_COUNTER_BUFFER_BINDINGS :: 0x92DC
MAX_ATOMIC_COUNTER_BUFFER_SIZE :: 0x92D8
MAX_COLOR_ATTACHMENTS :: 0x8CDF
MAX_COLOR_TEXTURE_SAMPLES :: 0x910E
MAX_COMBINED_ATOMIC_COUNTERS :: 0x92D7
MAX_COMBINED_ATOMIC_COUNTER_BUFFERS :: 0x92D1
MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS :: 0x8266
MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS :: 0x8A33
MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS :: 0x8A32
MAX_COMBINED_IMAGE_UNIFORMS :: 0x90CF
MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS :: 0x8F39
MAX_COMBINED_SHADER_OUTPUT_RESOURCES :: 0x8F39
MAX_COMBINED_SHADER_STORAGE_BLOCKS :: 0x90DC
MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS :: 0x8E1E
MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS :: 0x8E1F
MAX_COMBINED_TEXTURE_IMAGE_UNITS :: 0x8B4D
MAX_COMBINED_UNIFORM_BLOCKS :: 0x8A2E
MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS :: 0x8A31
MAX_COMPUTE_ATOMIC_COUNTERS :: 0x8265
MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS :: 0x8264
MAX_COMPUTE_IMAGE_UNIFORMS :: 0x91BD
MAX_COMPUTE_SHADER_STORAGE_BLOCKS :: 0x90DB
MAX_COMPUTE_SHARED_MEMORY_SIZE :: 0x8262
MAX_COMPUTE_TEXTURE_IMAGE_UNITS :: 0x91BC
MAX_COMPUTE_UNIFORM_BLOCKS :: 0x91BB
MAX_COMPUTE_UNIFORM_COMPONENTS :: 0x8263
MAX_COMPUTE_WORK_GROUP_COUNT :: 0x91BE
MAX_COMPUTE_WORK_GROUP_INVOCATIONS :: 0x90EB
MAX_COMPUTE_WORK_GROUP_SIZE :: 0x91BF
MAX_CUBE_MAP_TEXTURE_SIZE :: 0x851C
MAX_DEBUG_GROUP_STACK_DEPTH :: 0x826C
MAX_DEBUG_LOGGED_MESSAGES :: 0x9144
MAX_DEBUG_MESSAGE_LENGTH :: 0x9143
MAX_DEPTH_TEXTURE_SAMPLES :: 0x910F
MAX_DRAW_BUFFERS :: 0x8824
MAX_ELEMENTS_INDICES :: 0x80E9
MAX_ELEMENTS_VERTICES :: 0x80E8
MAX_ELEMENT_INDEX :: 0x8D6B
MAX_FRAGMENT_ATOMIC_COUNTERS :: 0x92D6
MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS :: 0x92D0
MAX_FRAGMENT_IMAGE_UNIFORMS :: 0x90CE
MAX_FRAGMENT_INPUT_COMPONENTS :: 0x9125
MAX_FRAGMENT_INTERPOLATION_OFFSET :: 0x8E5C
MAX_FRAGMENT_SHADER_STORAGE_BLOCKS :: 0x90DA
MAX_FRAGMENT_UNIFORM_BLOCKS :: 0x8A2D
MAX_FRAGMENT_UNIFORM_COMPONENTS :: 0x8B49
MAX_FRAGMENT_UNIFORM_VECTORS :: 0x8DFD
MAX_FRAMEBUFFER_HEIGHT :: 0x9316
MAX_FRAMEBUFFER_LAYERS :: 0x9317
MAX_FRAMEBUFFER_SAMPLES :: 0x9318
MAX_FRAMEBUFFER_WIDTH :: 0x9315
MAX_GEOMETRY_ATOMIC_COUNTERS :: 0x92D5
MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS :: 0x92CF
MAX_GEOMETRY_IMAGE_UNIFORMS :: 0x90CD
MAX_GEOMETRY_INPUT_COMPONENTS :: 0x9123
MAX_GEOMETRY_OUTPUT_COMPONENTS :: 0x9124
MAX_GEOMETRY_OUTPUT_VERTICES :: 0x8DE0
MAX_GEOMETRY_SHADER_INVOCATIONS :: 0x8E5A
MAX_GEOMETRY_SHADER_STORAGE_BLOCKS :: 0x90D7
MAX_GEOMETRY_TEXTURE_IMAGE_UNITS :: 0x8C29
MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS :: 0x8DE1
MAX_GEOMETRY_UNIFORM_BLOCKS :: 0x8A2C
MAX_GEOMETRY_UNIFORM_COMPONENTS :: 0x8DDF
MAX_IMAGE_UNITS :: 0x8F38
MAX_INTEGER_SAMPLES :: 0x9110
MAX_LABEL_LENGTH :: 0x82E8
MAX_NAME_LENGTH :: 0x92F6
MAX_NUM_ACTIVE_VARIABLES :: 0x92F7
MAX_PATCH_VERTICES :: 0x8E7D
MAX_PROGRAM_TEXEL_OFFSET :: 0x8905
MAX_PROGRAM_TEXTURE_GATHER_OFFSET :: 0x8E5F
MAX_RENDERBUFFER_SIZE :: 0x84E8
MAX_SAMPLES :: 0x8D57
MAX_SAMPLE_MASK_WORDS :: 0x8E59
MAX_SERVER_WAIT_TIMEOUT :: 0x9111
MAX_SHADER_STORAGE_BLOCK_SIZE :: 0x90DE
MAX_SHADER_STORAGE_BUFFER_BINDINGS :: 0x90DD
MAX_TESS_CONTROL_ATOMIC_COUNTERS :: 0x92D3
MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS :: 0x92CD
MAX_TESS_CONTROL_IMAGE_UNIFORMS :: 0x90CB
MAX_TESS_CONTROL_INPUT_COMPONENTS :: 0x886C
MAX_TESS_CONTROL_OUTPUT_COMPONENTS :: 0x8E83
MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS :: 0x90D8
MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS :: 0x8E81
MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS :: 0x8E85
MAX_TESS_CONTROL_UNIFORM_BLOCKS :: 0x8E89
MAX_TESS_CONTROL_UNIFORM_COMPONENTS :: 0x8E7F
MAX_TESS_EVALUATION_ATOMIC_COUNTERS :: 0x92D4
MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS :: 0x92CE
MAX_TESS_EVALUATION_IMAGE_UNIFORMS :: 0x90CC
MAX_TESS_EVALUATION_INPUT_COMPONENTS :: 0x886D
MAX_TESS_EVALUATION_OUTPUT_COMPONENTS :: 0x8E86
MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS :: 0x90D9
MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS :: 0x8E82
MAX_TESS_EVALUATION_UNIFORM_BLOCKS :: 0x8E8A
MAX_TESS_EVALUATION_UNIFORM_COMPONENTS :: 0x8E80
MAX_TESS_GEN_LEVEL :: 0x8E7E
MAX_TESS_PATCH_COMPONENTS :: 0x8E84
MAX_TEXTURE_BUFFER_SIZE :: 0x8C2B
MAX_TEXTURE_IMAGE_UNITS :: 0x8872
MAX_TEXTURE_LOD_BIAS :: 0x84FD
MAX_TEXTURE_SIZE :: 0x0D33
MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS :: 0x8C8A
MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS :: 0x8C8B
MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS :: 0x8C80
MAX_UNIFORM_BLOCK_SIZE :: 0x8A30
MAX_UNIFORM_BUFFER_BINDINGS :: 0x8A2F
MAX_UNIFORM_LOCATIONS :: 0x826E
MAX_VARYING_COMPONENTS :: 0x8B4B
MAX_VARYING_FLOATS :: 0x8B4B
MAX_VARYING_VECTORS :: 0x8DFC
MAX_VERTEX_ATOMIC_COUNTERS :: 0x92D2
MAX_VERTEX_ATOMIC_COUNTER_BUFFERS :: 0x92CC
MAX_VERTEX_ATTRIBS :: 0x8869
MAX_VERTEX_ATTRIB_BINDINGS :: 0x82DA
MAX_VERTEX_ATTRIB_RELATIVE_OFFSET :: 0x82D9
MAX_VERTEX_ATTRIB_STRIDE :: 0x82E5
MAX_VERTEX_IMAGE_UNIFORMS :: 0x90CA
MAX_VERTEX_OUTPUT_COMPONENTS :: 0x9122
MAX_VERTEX_SHADER_STORAGE_BLOCKS :: 0x90D6
MAX_VERTEX_TEXTURE_IMAGE_UNITS :: 0x8B4C
MAX_VERTEX_UNIFORM_BLOCKS :: 0x8A2B
MAX_VERTEX_UNIFORM_COMPONENTS :: 0x8B4A
MAX_VERTEX_UNIFORM_VECTORS :: 0x8DFB
MAX_VIEWPORT_DIMS :: 0x0D3A
MEDIUM_FLOAT :: 0x8DF1
MEDIUM_INT :: 0x8DF4
MIN :: 0x8007
MINOR_VERSION :: 0x821C
MIN_FRAGMENT_INTERPOLATION_OFFSET :: 0x8E5B
MIN_PROGRAM_TEXEL_OFFSET :: 0x8904
MIN_PROGRAM_TEXTURE_GATHER_OFFSET :: 0x8E5E
MIN_SAMPLE_SHADING_VALUE :: 0x8C37
MIRRORED_REPEAT :: 0x8370
MULTIPLY :: 0x9294
MULTISAMPLE_LINE_WIDTH_GRANULARITY :: 0x9382
MULTISAMPLE_LINE_WIDTH_RANGE :: 0x9381
NAME_LENGTH :: 0x92F9
NEAREST :: 0x2600
NEAREST_MIPMAP_LINEAR :: 0x2702
NEAREST_MIPMAP_NEAREST :: 0x2700
NEVER :: 0x0200
NICEST :: 0x1102
NONE :: 0
NOTEQUAL :: 0x0205
NO_ERROR :: 0
NO_RESET_NOTIFICATION :: 0x8261
NUM_ACTIVE_VARIABLES :: 0x9304
NUM_COMPRESSED_TEXTURE_FORMATS :: 0x86A2
NUM_EXTENSIONS :: 0x821D
NUM_PROGRAM_BINARY_FORMATS :: 0x87FE
NUM_SAMPLE_COUNTS :: 0x9380
NUM_SHADER_BINARY_FORMATS :: 0x8DF9
OBJECT_TYPE :: 0x9112
OFFSET :: 0x92FC
ONE :: 1
ONE_MINUS_CONSTANT_ALPHA :: 0x8004
ONE_MINUS_CONSTANT_COLOR :: 0x8002
ONE_MINUS_DST_ALPHA :: 0x0305
ONE_MINUS_DST_COLOR :: 0x0307
ONE_MINUS_SRC_ALPHA :: 0x0303
ONE_MINUS_SRC_COLOR :: 0x0301
OUT_OF_MEMORY :: 0x0505
OVERLAY :: 0x9296
PACK_ALIGNMENT :: 0x0D05
PACK_ROW_LENGTH :: 0x0D02
PACK_SKIP_PIXELS :: 0x0D04
PACK_SKIP_ROWS :: 0x0D03
PATCHES :: 0x000E
PATCH_VERTICES :: 0x8E72
PIXEL_BUFFER_BARRIER_BIT :: 0x00000080
PIXEL_PACK_BUFFER :: 0x88EB
PIXEL_PACK_BUFFER_BINDING :: 0x88ED
PIXEL_UNPACK_BUFFER :: 0x88EC
PIXEL_UNPACK_BUFFER_BINDING :: 0x88EF
POINTS :: 0x0000
POLYGON_OFFSET_FACTOR :: 0x8038
POLYGON_OFFSET_FILL :: 0x8037
POLYGON_OFFSET_UNITS :: 0x2A00
PRIMITIVES_GENERATED :: 0x8C87
PRIMITIVE_BOUNDING_BOX :: 0x92BE
PRIMITIVE_RESTART_FIXED_INDEX :: 0x8D69
PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED :: 0x8221
PROGRAM :: 0x82E2
PROGRAM_BINARY_FORMATS :: 0x87FF
PROGRAM_BINARY_LENGTH :: 0x8741
PROGRAM_BINARY_RETRIEVABLE_HINT :: 0x8257
PROGRAM_INPUT :: 0x92E3
PROGRAM_OUTPUT :: 0x92E4
PROGRAM_PIPELINE :: 0x82E4
PROGRAM_PIPELINE_BINDING :: 0x825A
PROGRAM_SEPARABLE :: 0x8258
QUADS :: 0x0007
QUERY :: 0x82E3
QUERY_RESULT :: 0x8866
QUERY_RESULT_AVAILABLE :: 0x8867
R11F_G11F_B10F :: 0x8C3A
R16F :: 0x822D
R16I :: 0x8233
R16UI :: 0x8234
R32F :: 0x822E
R32I :: 0x8235
R32UI :: 0x8236
R8 :: 0x8229
R8I :: 0x8231
R8UI :: 0x8232
R8_SNORM :: 0x8F94
RASTERIZER_DISCARD :: 0x8C89
READ_BUFFER :: 0x0C02
READ_FRAMEBUFFER :: 0x8CA8
READ_FRAMEBUFFER_BINDING :: 0x8CAA
READ_ONLY :: 0x88B8
READ_WRITE :: 0x88BA
RED :: 0x1903
RED_BITS :: 0x0D52
RED_INTEGER :: 0x8D94
REFERENCED_BY_COMPUTE_SHADER :: 0x930B
REFERENCED_BY_FRAGMENT_SHADER :: 0x930A
REFERENCED_BY_GEOMETRY_SHADER :: 0x9309
REFERENCED_BY_TESS_CONTROL_SHADER :: 0x9307
REFERENCED_BY_TESS_EVALUATION_SHADER :: 0x9308
REFERENCED_BY_VERTEX_SHADER :: 0x9306
RENDERBUFFER :: 0x8D41
RENDERBUFFER_ALPHA_SIZE :: 0x8D53
RENDERBUFFER_BINDING :: 0x8CA7
RENDERBUFFER_BLUE_SIZE :: 0x8D52
RENDERBUFFER_DEPTH_SIZE :: 0x8D54
RENDERBUFFER_GREEN_SIZE :: 0x8D51
RENDERBUFFER_HEIGHT :: 0x8D43
RENDERBUFFER_INTERNAL_FORMAT :: 0x8D44
RENDERBUFFER_RED_SIZE :: 0x8D50
RENDERBUFFER_SAMPLES :: 0x8CAB
RENDERBUFFER_STENCIL_SIZE :: 0x8D55
RENDERBUFFER_WIDTH :: 0x8D42
RENDERER :: 0x1F01
REPEAT :: 0x2901
REPLACE :: 0x1E01
RESET_NOTIFICATION_STRATEGY :: 0x8256
RG :: 0x8227
RG16F :: 0x822F
RG16I :: 0x8239
RG16UI :: 0x823A
RG32F :: 0x8230
RG32I :: 0x823B
RG32UI :: 0x823C
RG8 :: 0x822B
RG8I :: 0x8237
RG8UI :: 0x8238
RG8_SNORM :: 0x8F95
RGB :: 0x1907
RGB10_A2 :: 0x8059
RGB10_A2UI :: 0x906F
RGB16F :: 0x881B
RGB16I :: 0x8D89
RGB16UI :: 0x8D77
RGB32F :: 0x8815
RGB32I :: 0x8D83
RGB32UI :: 0x8D71
RGB565 :: 0x8D62
RGB5_A1 :: 0x8057
RGB8 :: 0x8051
RGB8I :: 0x8D8F
RGB8UI :: 0x8D7D
RGB8_SNORM :: 0x8F96
RGB9_E5 :: 0x8C3D
RGBA :: 0x1908
RGBA16F :: 0x881A
RGBA16I :: 0x8D88
RGBA16UI :: 0x8D76
RGBA32F :: 0x8814
RGBA32I :: 0x8D82
RGBA32UI :: 0x8D70
RGBA4 :: 0x8056
RGBA8 :: 0x8058
RGBA8I :: 0x8D8E
RGBA8UI :: 0x8D7C
RGBA8_SNORM :: 0x8F97
RGBA_INTEGER :: 0x8D99
RGB_INTEGER :: 0x8D98
RG_INTEGER :: 0x8228
SAMPLER :: 0x82E6
SAMPLER_2D :: 0x8B5E
SAMPLER_2D_ARRAY :: 0x8DC1
SAMPLER_2D_ARRAY_SHADOW :: 0x8DC4
SAMPLER_2D_MULTISAMPLE :: 0x9108
SAMPLER_2D_MULTISAMPLE_ARRAY :: 0x910B
SAMPLER_2D_SHADOW :: 0x8B62
SAMPLER_3D :: 0x8B5F
SAMPLER_BINDING :: 0x8919
SAMPLER_BUFFER :: 0x8DC2
SAMPLER_CUBE :: 0x8B60
SAMPLER_CUBE_MAP_ARRAY :: 0x900C
SAMPLER_CUBE_MAP_ARRAY_SHADOW :: 0x900D
SAMPLER_CUBE_SHADOW :: 0x8DC5
SAMPLES :: 0x80A9
SAMPLE_ALPHA_TO_COVERAGE :: 0x809E
SAMPLE_BUFFERS :: 0x80A8
SAMPLE_COVERAGE :: 0x80A0
SAMPLE_COVERAGE_INVERT :: 0x80AB
SAMPLE_COVERAGE_VALUE :: 0x80AA
SAMPLE_MASK :: 0x8E51
SAMPLE_MASK_VALUE :: 0x8E52
SAMPLE_POSITION :: 0x8E50
SAMPLE_SHADING :: 0x8C36
SCISSOR_BOX :: 0x0C10
SCISSOR_TEST :: 0x0C11
SCREEN :: 0x9295
SEPARATE_ATTRIBS :: 0x8C8D
SHADER :: 0x82E1
SHADER_BINARY_FORMATS :: 0x8DF8
SHADER_COMPILER :: 0x8DFA
SHADER_IMAGE_ACCESS_BARRIER_BIT :: 0x00000020
SHADER_SOURCE_LENGTH :: 0x8B88
SHADER_STORAGE_BARRIER_BIT :: 0x00002000
SHADER_STORAGE_BLOCK :: 0x92E6
SHADER_STORAGE_BUFFER :: 0x90D2
SHADER_STORAGE_BUFFER_BINDING :: 0x90D3
SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT :: 0x90DF
SHADER_STORAGE_BUFFER_SIZE :: 0x90D5
SHADER_STORAGE_BUFFER_START :: 0x90D4
SHADER_TYPE :: 0x8B4F
SHADING_LANGUAGE_VERSION :: 0x8B8C
SHORT :: 0x1402
SIGNALED :: 0x9119
SIGNED_NORMALIZED :: 0x8F9C
SOFTLIGHT :: 0x929C
SRC_ALPHA :: 0x0302
SRC_ALPHA_SATURATE :: 0x0308
SRC_COLOR :: 0x0300
SRGB :: 0x8C40
SRGB8 :: 0x8C41
SRGB8_ALPHA8 :: 0x8C43
STACK_OVERFLOW :: 0x0503
STACK_UNDERFLOW :: 0x0504
STATIC_COPY :: 0x88E6
STATIC_DRAW :: 0x88E4
STATIC_READ :: 0x88E5
STENCIL :: 0x1802
STENCIL_ATTACHMENT :: 0x8D20
STENCIL_BACK_FAIL :: 0x8801
STENCIL_BACK_FUNC :: 0x8800
STENCIL_BACK_PASS_DEPTH_FAIL :: 0x8802
STENCIL_BACK_PASS_DEPTH_PASS :: 0x8803
STENCIL_BACK_REF :: 0x8CA3
STENCIL_BACK_VALUE_MASK :: 0x8CA4
STENCIL_BACK_WRITEMASK :: 0x8CA5
STENCIL_BITS :: 0x0D57
STENCIL_BUFFER_BIT :: 0x00000400
STENCIL_CLEAR_VALUE :: 0x0B91
STENCIL_FAIL :: 0x0B94
STENCIL_FUNC :: 0x0B92
STENCIL_INDEX :: 0x1901
STENCIL_INDEX8 :: 0x8D48
STENCIL_PASS_DEPTH_FAIL :: 0x0B95
STENCIL_PASS_DEPTH_PASS :: 0x0B96
STENCIL_REF :: 0x0B97
STENCIL_TEST :: 0x0B90
STENCIL_VALUE_MASK :: 0x0B93
STENCIL_WRITEMASK :: 0x0B98
STREAM_COPY :: 0x88E2
STREAM_DRAW :: 0x88E0
STREAM_READ :: 0x88E1
SUBPIXEL_BITS :: 0x0D50
SYNC_CONDITION :: 0x9113
SYNC_FENCE :: 0x9116
SYNC_FLAGS :: 0x9115
SYNC_FLUSH_COMMANDS_BIT :: 0x00000001
SYNC_GPU_COMMANDS_COMPLETE :: 0x9117
SYNC_STATUS :: 0x9114
TESS_CONTROL_OUTPUT_VERTICES :: 0x8E75
TESS_CONTROL_SHADER :: 0x8E88
TESS_CONTROL_SHADER_BIT :: 0x00000008
TESS_EVALUATION_SHADER :: 0x8E87
TESS_EVALUATION_SHADER_BIT :: 0x00000010
TESS_GEN_MODE :: 0x8E76
TESS_GEN_POINT_MODE :: 0x8E79
TESS_GEN_SPACING :: 0x8E77
TESS_GEN_VERTEX_ORDER :: 0x8E78
TEXTURE :: 0x1702
TEXTURE0 :: 0x84C0
TEXTURE1 :: 0x84C1
TEXTURE10 :: 0x84CA
TEXTURE11 :: 0x84CB
TEXTURE12 :: 0x84CC
TEXTURE13 :: 0x84CD
TEXTURE14 :: 0x84CE
TEXTURE15 :: 0x84CF
TEXTURE16 :: 0x84D0
TEXTURE17 :: 0x84D1
TEXTURE18 :: 0x84D2
TEXTURE19 :: 0x84D3
TEXTURE2 :: 0x84C2
TEXTURE20 :: 0x84D4
TEXTURE21 :: 0x84D5
TEXTURE22 :: 0x84D6
TEXTURE23 :: 0x84D7
TEXTURE24 :: 0x84D8
TEXTURE25 :: 0x84D9
TEXTURE26 :: 0x84DA
TEXTURE27 :: 0x84DB
TEXTURE28 :: 0x84DC
TEXTURE29 :: 0x84DD
TEXTURE3 :: 0x84C3
TEXTURE30 :: 0x84DE
TEXTURE31 :: 0x84DF
TEXTURE4 :: 0x84C4
TEXTURE5 :: 0x84C5
TEXTURE6 :: 0x84C6
TEXTURE7 :: 0x84C7
TEXTURE8 :: 0x84C8
TEXTURE9 :: 0x84C9
TEXTURE_2D :: 0x0DE1
TEXTURE_2D_ARRAY :: 0x8C1A
TEXTURE_2D_MULTISAMPLE :: 0x9100
TEXTURE_2D_MULTISAMPLE_ARRAY :: 0x9102
TEXTURE_3D :: 0x806F
TEXTURE_ALPHA_SIZE :: 0x805F
TEXTURE_ALPHA_TYPE :: 0x8C13
TEXTURE_BASE_LEVEL :: 0x813C
TEXTURE_BINDING_2D :: 0x8069
TEXTURE_BINDING_2D_ARRAY :: 0x8C1D
TEXTURE_BINDING_2D_MULTISAMPLE :: 0x9104
TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY :: 0x9105
TEXTURE_BINDING_3D :: 0x806A
TEXTURE_BINDING_BUFFER :: 0x8C2C
TEXTURE_BINDING_CUBE_MAP :: 0x8514
TEXTURE_BINDING_CUBE_MAP_ARRAY :: 0x900A
TEXTURE_BLUE_SIZE :: 0x805E
TEXTURE_BLUE_TYPE :: 0x8C12
TEXTURE_BORDER_COLOR :: 0x1004
TEXTURE_BUFFER :: 0x8C2A
TEXTURE_BUFFER_BINDING :: 0x8C2A
TEXTURE_BUFFER_DATA_STORE_BINDING :: 0x8C2D
TEXTURE_BUFFER_OFFSET :: 0x919D
TEXTURE_BUFFER_OFFSET_ALIGNMENT :: 0x919F
TEXTURE_BUFFER_SIZE :: 0x919E
TEXTURE_COMPARE_FUNC :: 0x884D
TEXTURE_COMPARE_MODE :: 0x884C
TEXTURE_COMPRESSED :: 0x86A1
TEXTURE_CUBE_MAP :: 0x8513
TEXTURE_CUBE_MAP_ARRAY :: 0x9009
TEXTURE_CUBE_MAP_NEGATIVE_X :: 0x8516
TEXTURE_CUBE_MAP_NEGATIVE_Y :: 0x8518
TEXTURE_CUBE_MAP_NEGATIVE_Z :: 0x851A
TEXTURE_CUBE_MAP_POSITIVE_X :: 0x8515
TEXTURE_CUBE_MAP_POSITIVE_Y :: 0x8517
TEXTURE_CUBE_MAP_POSITIVE_Z :: 0x8519
TEXTURE_DEPTH :: 0x8071
TEXTURE_DEPTH_SIZE :: 0x884A
TEXTURE_DEPTH_TYPE :: 0x8C16
TEXTURE_FETCH_BARRIER_BIT :: 0x00000008
TEXTURE_FIXED_SAMPLE_LOCATIONS :: 0x9107
TEXTURE_GREEN_SIZE :: 0x805D
TEXTURE_GREEN_TYPE :: 0x8C11
TEXTURE_HEIGHT :: 0x1001
TEXTURE_IMMUTABLE_FORMAT :: 0x912F
TEXTURE_IMMUTABLE_LEVELS :: 0x82DF
TEXTURE_INTERNAL_FORMAT :: 0x1003
TEXTURE_MAG_FILTER :: 0x2800
TEXTURE_MAX_LEVEL :: 0x813D
TEXTURE_MAX_LOD :: 0x813B
TEXTURE_MIN_FILTER :: 0x2801
TEXTURE_MIN_LOD :: 0x813A
TEXTURE_RED_SIZE :: 0x805C
TEXTURE_RED_TYPE :: 0x8C10
TEXTURE_SAMPLES :: 0x9106
TEXTURE_SHARED_SIZE :: 0x8C3F
TEXTURE_STENCIL_SIZE :: 0x88F1
TEXTURE_SWIZZLE_A :: 0x8E45
TEXTURE_SWIZZLE_B :: 0x8E44
TEXTURE_SWIZZLE_G :: 0x8E43
TEXTURE_SWIZZLE_R :: 0x8E42
TEXTURE_UPDATE_BARRIER_BIT :: 0x00000100
TEXTURE_WIDTH :: 0x1000
TEXTURE_WRAP_R :: 0x8072
TEXTURE_WRAP_S :: 0x2802
TEXTURE_WRAP_T :: 0x2803
TIMEOUT_EXPIRED :: 0x911B
TIMEOUT_IGNORED :: 0xFFFFFFFFFFFFFFFF
TOP_LEVEL_ARRAY_SIZE :: 0x930C
TOP_LEVEL_ARRAY_STRIDE :: 0x930D
TRANSFORM_FEEDBACK :: 0x8E22
TRANSFORM_FEEDBACK_ACTIVE :: 0x8E24
TRANSFORM_FEEDBACK_BARRIER_BIT :: 0x00000800
TRANSFORM_FEEDBACK_BINDING :: 0x8E25
TRANSFORM_FEEDBACK_BUFFER :: 0x8C8E
TRANSFORM_FEEDBACK_BUFFER_ACTIVE :: 0x8E24
TRANSFORM_FEEDBACK_BUFFER_BINDING :: 0x8C8F
TRANSFORM_FEEDBACK_BUFFER_MODE :: 0x8C7F
TRANSFORM_FEEDBACK_BUFFER_PAUSED :: 0x8E23
TRANSFORM_FEEDBACK_BUFFER_SIZE :: 0x8C85
TRANSFORM_FEEDBACK_BUFFER_START :: 0x8C84
TRANSFORM_FEEDBACK_PAUSED :: 0x8E23
TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN :: 0x8C88
TRANSFORM_FEEDBACK_VARYING :: 0x92F4
TRANSFORM_FEEDBACK_VARYINGS :: 0x8C83
TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH :: 0x8C76
TRIANGLES :: 0x0004
TRIANGLES_ADJACENCY :: 0x000C
TRIANGLE_FAN :: 0x0006
TRIANGLE_STRIP :: 0x0005
TRIANGLE_STRIP_ADJACENCY :: 0x000D
TRUE :: 1
TYPE :: 0x92FA
UNDEFINED_VERTEX :: 0x8260
UNIFORM :: 0x92E1
UNIFORM_ARRAY_STRIDE :: 0x8A3C
UNIFORM_BARRIER_BIT :: 0x00000004
UNIFORM_BLOCK :: 0x92E2
UNIFORM_BLOCK_ACTIVE_UNIFORMS :: 0x8A42
UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES :: 0x8A43
UNIFORM_BLOCK_BINDING :: 0x8A3F
UNIFORM_BLOCK_DATA_SIZE :: 0x8A40
UNIFORM_BLOCK_INDEX :: 0x8A3A
UNIFORM_BLOCK_NAME_LENGTH :: 0x8A41
UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER :: 0x8A46
UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER :: 0x8A44
UNIFORM_BUFFER :: 0x8A11
UNIFORM_BUFFER_BINDING :: 0x8A28
UNIFORM_BUFFER_OFFSET_ALIGNMENT :: 0x8A34
UNIFORM_BUFFER_SIZE :: 0x8A2A
UNIFORM_BUFFER_START :: 0x8A29
UNIFORM_IS_ROW_MAJOR :: 0x8A3E
UNIFORM_MATRIX_STRIDE :: 0x8A3D
UNIFORM_NAME_LENGTH :: 0x8A39
UNIFORM_OFFSET :: 0x8A3B
UNIFORM_SIZE :: 0x8A38
UNIFORM_TYPE :: 0x8A37
UNKNOWN_CONTEXT_RESET :: 0x8255
UNPACK_ALIGNMENT :: 0x0CF5
UNPACK_IMAGE_HEIGHT :: 0x806E
UNPACK_ROW_LENGTH :: 0x0CF2
UNPACK_SKIP_IMAGES :: 0x806D
UNPACK_SKIP_PIXELS :: 0x0CF4
UNPACK_SKIP_ROWS :: 0x0CF3
UNSIGNALED :: 0x9118
UNSIGNED_BYTE :: 0x1401
UNSIGNED_INT :: 0x1405
UNSIGNED_INT_10F_11F_11F_REV :: 0x8C3B
UNSIGNED_INT_24_8 :: 0x84FA
UNSIGNED_INT_2_10_10_10_REV :: 0x8368
UNSIGNED_INT_5_9_9_9_REV :: 0x8C3E
UNSIGNED_INT_ATOMIC_COUNTER :: 0x92DB
UNSIGNED_INT_IMAGE_2D :: 0x9063
UNSIGNED_INT_IMAGE_2D_ARRAY :: 0x9069
UNSIGNED_INT_IMAGE_3D :: 0x9064
UNSIGNED_INT_IMAGE_BUFFER :: 0x9067
UNSIGNED_INT_IMAGE_CUBE :: 0x9066
UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY :: 0x906A
UNSIGNED_INT_SAMPLER_2D :: 0x8DD2
UNSIGNED_INT_SAMPLER_2D_ARRAY :: 0x8DD7
UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE :: 0x910A
UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY :: 0x910D
UNSIGNED_INT_SAMPLER_3D :: 0x8DD3
UNSIGNED_INT_SAMPLER_BUFFER :: 0x8DD8
UNSIGNED_INT_SAMPLER_CUBE :: 0x8DD4
UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY :: 0x900F
UNSIGNED_INT_VEC2 :: 0x8DC6
UNSIGNED_INT_VEC3 :: 0x8DC7
UNSIGNED_INT_VEC4 :: 0x8DC8
UNSIGNED_NORMALIZED :: 0x8C17
UNSIGNED_SHORT :: 0x1403
UNSIGNED_SHORT_4_4_4_4 :: 0x8033
UNSIGNED_SHORT_5_5_5_1 :: 0x8034
UNSIGNED_SHORT_5_6_5 :: 0x8363
VALIDATE_STATUS :: 0x8B83
VENDOR :: 0x1F00
VERSION :: 0x1F02
VERTEX_ARRAY :: 0x8074
VERTEX_ARRAY_BINDING :: 0x85B5
VERTEX_ATTRIB_ARRAY_BARRIER_BIT :: 0x00000001
VERTEX_ATTRIB_ARRAY_BUFFER_BINDING :: 0x889F
VERTEX_ATTRIB_ARRAY_DIVISOR :: 0x88FE
VERTEX_ATTRIB_ARRAY_ENABLED :: 0x8622
VERTEX_ATTRIB_ARRAY_INTEGER :: 0x88FD
VERTEX_ATTRIB_ARRAY_NORMALIZED :: 0x886A
VERTEX_ATTRIB_ARRAY_POINTER :: 0x8645
VERTEX_ATTRIB_ARRAY_SIZE :: 0x8623
VERTEX_ATTRIB_ARRAY_STRIDE :: 0x8624
VERTEX_ATTRIB_ARRAY_TYPE :: 0x8625
VERTEX_ATTRIB_BINDING :: 0x82D4
VERTEX_ATTRIB_RELATIVE_OFFSET :: 0x82D5
VERTEX_BINDING_BUFFER :: 0x8F4F
VERTEX_BINDING_DIVISOR :: 0x82D6
VERTEX_BINDING_OFFSET :: 0x82D7
VERTEX_BINDING_STRIDE :: 0x82D8
VERTEX_SHADER :: 0x8B31
VERTEX_SHADER_BIT :: 0x00000001
VIEWPORT :: 0x0BA2
WAIT_FAILED :: 0x911D
WRITE_ONLY :: 0x88B9
ZERO :: 0
