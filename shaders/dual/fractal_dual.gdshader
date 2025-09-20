shader_type canvas_item;

uniform vec2 initial_z = vec2(0.0);
uniform vec2 c_value = vec2(-1.15, 0.26);
uniform vec2 x_value = vec2(2.0,0.0);

#include "res://shaders/rendering.gdshaderinc"
#include "dual_math.gdshaderinc"

uniform vec2 viewport_size;

vec4 draw(vec2 z, vec2 c, vec2 x) {
	int iterations = 0;
	
	for (int i = 0; i < max_iterations; i++) {
		if (length(z) == 0.0) {
			z = c;
		} else {
			// mandelbrot: 
			z = d_pow(z,x) + c;
		}
		
		if (length(z) > escape_value && use_escape_time_coloring) { break; }
		iterations++;
	}
	if (use_escape_time_coloring) {
		if (iterations == max_iterations) {
			return vec4(in_set_color/255.0, 1.0);
		} else {
			return vec4(color_getter_escape_time(iterations), 1.0);
		}
	}
}

void fragment() {
	vec2 uv = FRAGCOORD.xy - viewport_size/2.0;
	vec2 rot_vec = vec2(cos(rotation*PI/180.0), sin(rotation*PI/180.0));
	
	vec2 param = c_multiply(uv/(250.0*pow(sqrt(zoom),zoom)), rot_vec) + vec2(center.x, -center.y);
	
	if (var_on_pixels == 1) {
		COLOR = draw(param, c_value, x_value);
	} else if (var_on_pixels == 2) {
		COLOR = draw(initial_z, c_value, param);
	} else {
		COLOR = draw(initial_z, param, x_value);
	}
}