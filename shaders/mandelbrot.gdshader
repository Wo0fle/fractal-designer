shader_type canvas_item;

uniform vec2 initial_z = vec2(0.0);
uniform float exponent = 2.0;

uniform float zoom = 4.0;
uniform float center_x = 0.0;
uniform float center_y = 0.0;

uniform int max_iterations = 500;

uniform vec3 far_color = vec3(56, 95, 200);
uniform vec3 close_color = vec3(162, 240, 240);
uniform int amount_of_colors = 10;


vec3 color_getter(int cur_iteration) {
	vec3 far = far_color/255.0;
	vec3 close = close_color/255.0;

	vec3 color_difference = (close - far)/float(amount_of_colors);
	vec3 cur_color = far;

	cur_color += color_difference*float(cur_iteration % amount_of_colors);
	
	return cur_color;
}

void fragment() {
	vec2 uv = UV - 0.5;
	vec2 c = uv * zoom + vec2(center_x, -center_y);
	
	vec2 z = vec2(initial_z.x, -initial_z.y);
	
	int iterations = 0;
	
	for (int i = 0; i < max_iterations; i++) {
		z = vec2(pow(pow(z.x,2.0)+pow(z.y,2.0), exponent/2.0)*cos(exponent*atan(z.y,z.x)), pow(pow(z.x,2.0)+pow(z.y,2.0), exponent/2.0)*sin(exponent*atan(z.y,z.x))) + c;
		
		if (length(z) > 2.0) {
			break;
		}
		iterations++;
	}
	
	if (iterations == max_iterations) {
		COLOR = vec4(0,0,0,1);
	} else {
		COLOR = vec4(color_getter(iterations), 1.0);
	}
}