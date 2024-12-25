shader_type canvas_item;

uniform bvec3 var_on_pixels = bvec3(true, false, false);

#include "multibrot.gdshaderinc"

uniform vec2 initial_z = vec2(0.0);
uniform vec2 c_value = vec2(-1.15, 0.26);
uniform vec2 x_value = vec2(2.0,0.0);

uniform vec2 viewport_size;

void fragment() {
	vec2 uv = FRAGCOORD.xy - viewport_size/2.0;
	
	if (var_on_pixels[1] == true) {
		vec2 z = uv * zoom / 1000.0 + vec2(center_x, -center_y);
		COLOR = draw(z, c_value, x_value);
	} else if (var_on_pixels[2] == true) {
		vec2 x = uv * zoom / 1000.0 + vec2(center_x, -center_y);
		COLOR = draw(initial_z, c_value, x);
	} else {
		vec2 c = uv * zoom / 1000.0 + vec2(center_x, -center_y);
		COLOR = draw(initial_z, c, x_value);
	}
}