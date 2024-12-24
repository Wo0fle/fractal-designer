uniform float escape_value = 256.0;

uniform float zoom = 4.0;
uniform float center_x = 0.0;
uniform float center_y = 0.0;

uniform int max_iterations = 500;

uniform vec3 in_set_color = vec3(0);
uniform vec3 far_color = vec3(56, 95, 200);
uniform vec3 close_color = vec3(162, 240, 240);
uniform int amount_of_colors = 30;

vec3 color_getter(int cur_iteration) {
	vec3 far = far_color/255.0;
	vec3 close = close_color/255.0;

	vec3 color_difference = (close - far)/float(amount_of_colors);
	vec3 cur_color = far;

	cur_color += color_difference*float(cur_iteration % amount_of_colors);
	
	return cur_color;
}

float better_pow(float base, float power) {
	if (power > 0.0) {
		return pow(base, power);
	} else if (power == 0.0) {
		return 1.0;
	} else {
		return (1.0/pow(base, power));
	}
}

vec4 draw(vec2 z, vec2 c, vec2 x) {
	int iterations = 0;
	
	for (int i = 0; i < max_iterations; i++) {
		float r = length(z);
		float theta = atan(z.y,z.x);
		
		if (r == 0.0) {
			z = c;
			// why does this edge case exist...
		} else {
			z = vec2(better_pow(r,x.x)*exp(-x.y*theta)*cos((x.x*theta)+(x.y*log(r))), better_pow(r,x.x)*exp(-x.y*theta)*sin((x.x*theta)+(x.y*log(r)))) + c;
		}
		
		if (r > escape_value) {
			break;
		}
		iterations++;
	}
	
	if (iterations == max_iterations) {
		return vec4(in_set_color/255.0, 1.0);
	} else {
		return vec4(color_getter(iterations), 1.0);
	}
}