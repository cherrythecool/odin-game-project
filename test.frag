precision mediump float;

in vec2 uv;
out vec4 color;

uniform sampler2D cur_texture;

void main() {
    color = texture(cur_texture, uv);
}