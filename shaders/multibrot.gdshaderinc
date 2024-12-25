uniform float zoom = 4.0;
uniform float center_x = 0.0;
uniform float center_y = 0.0;

uniform bool use_lyapunov = false;

uniform int max_iterations = 500;
uniform float escape_value = 256.0;

uniform vec3 in_set_color = vec3(0);
uniform vec3 far_color = vec3(56, 95, 200);
uniform vec3 close_color = vec3(162, 240, 240);
uniform int amount_of_colors = 30;

vec3 color_getter_le(float lyapunov) {
	// eventually color based on period?
	
	// also, it doesn't work for Re(x) < -1 rn which kinda defeats the purpose sooooooo
	// probably replace lyapunov exponent algorithm with some other periodicity detection?
	
	if (lyapunov <= 0.0) {
		return in_set_color;
	} else {
		return far_color/255.0;
	}
}

vec3 color_getter_et(int cur_iteration) {
	// doesn't work from [-1,1] on Re(x)
	// but i SWEAR it was earlier today???
	
	vec3 far = far_color/255.0;
	vec3 close = close_color/255.0;

	vec3 color_difference = (close - far)/float(amount_of_colors);
	vec3 cur_color = far;
	
	cur_color += color_difference*float(cur_iteration % amount_of_colors);
	
	return cur_color;
}

vec4 draw(vec2 z, vec2 c, vec2 x) {
	float le = 0.0;
	int iterations = 0;
	
	for (int i = 0; i < max_iterations; i++) {
		float r = length(z);
		float theta = atan(z.y,z.x);
		
		if (r == 0.0) {
			z = c;
		} else {
			if (use_lyapunov) { le += log(r); }
			z = vec2(
				pow(r,x.x)*exp(-x.y*theta)*cos((x.x*theta)+(x.y*log(r))),
				pow(r,x.x)*exp(-x.y*theta)*sin((x.x*theta)+(x.y*log(r)))
			) + c;
		}
		
		if (length(z) > escape_value && !use_lyapunov) { break; }
		iterations++;
	}
	if (use_lyapunov) { 
		le += log(length(z)); // to cover that very last iteration
		le /= float(max_iterations);
		return vec4(color_getter_le(le), 1.0);
	} else {
		if (iterations == max_iterations) { return vec4(in_set_color/255.0, 1.0);
		} else { return vec4(color_getter_et(iterations), 1.0); }
		
	}
}