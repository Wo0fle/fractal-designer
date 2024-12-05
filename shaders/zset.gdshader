shader_type canvas_item;

#include "overall.gdshaderinc"

uniform vec2 initial_c = vec2(-1.15, 0.26);

void fragment() {
	vec2 uv = UV - 0.5;
	vec2 z = uv * zoom + vec2(center_x, -center_y);
	
	vec2 c = vec2(initial_c.x, -initial_c.y);
	
	COLOR = draw(z, c);
}