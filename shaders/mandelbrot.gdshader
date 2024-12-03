shader_type canvas_item;

uniform float zoom = 4.0;
uniform float center_x = 0.0;
uniform float center_y = 0.0;
uniform int max_iterations = 20;
uniform vec3 far_color = vec3(0.0, 0.0, 0.0);
uniform vec3 close_color = vec3(0.0, 73.0, 255.0);

void fragment() {	
	vec2 uv = UV - 0.5;
	vec2 z = vec2(0.0);
	vec2 c = uv * zoom + vec2(center_x, -center_y);
	
	float iterations = 0.0;
	
	for (int i = 0; i < max_iterations; i++) {
		z = vec2(z.x * z.x - z.y * z.y, 2.0 * z.x * z.y) + c;
		if (length(z) > 2.0) {
			break;
		}
		iterations++;
	}
	
	// create an array of colors from far_color to close_color
	// set the color of the current point to the "iterations % color_array.length"nth element of color_array
	
	float iteration_ratio = iterations / float(max_iterations);
	COLOR = vec4(iteration_ratio, iteration_ratio, iteration_ratio, 1.0);
}
