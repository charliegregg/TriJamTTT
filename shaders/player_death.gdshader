shader_type canvas_item;

uniform sampler2D noise;
uniform float noise_amp;

void fragment() {
	float d = length(UV - vec2(0.5)) * 1.414;
	COLOR.rgb -= max(0, 3.0 * noise_amp + texture(noise, UV).r + 3.0 * d - 4.5);
	COLOR.a -= max(0, 3.0 * noise_amp + texture(noise, UV).r + 3.0 * d - 5.5);
}
