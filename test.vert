#version 320 es
precision mediump float;

layout (location = 0) in vec2 position;
layout (location = 1) in vec2 textureCoords;

uniform mat4 projection;
uniform mat4 transform;

out vec2 uv;

void main() {
    gl_Position = projection * transform * vec4(position.x, position.y, 0.0, 1.0);
    uv = textureCoords;
}