shader_type canvas_item;

#include "overall.gdshaderinc"

uniform vec2 c_value = vec2(-1.15, 0.26);
uniform vec2 x_value = vec2(2.0,0.0);

uniform vec2 viewport_size;

void fragment() {
	vec2 uv = FRAGCOORD.xy - viewport_size/2.0;
	vec2 z = uv * zoom / 1000.0 + vec2(center_x, -center_y);
	
	COLOR = draw(z, c_value, x_value);
}