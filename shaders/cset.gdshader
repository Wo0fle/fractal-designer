shader_type canvas_item;

#include "overall.gdshaderinc"

uniform vec2 initial_z = vec2(0.0);

void fragment() {
	vec2 uv = UV - 0.5;
	vec2 c = uv * zoom + vec2(center_x, -center_y);
	
	vec2 z = vec2(initial_z.x, -initial_z.y);
	
	COLOR = draw(z, c);
}