uniform bvec3 var_on_pixels = bvec3(true, false, false);

uniform float zoom = 4.0;
uniform vec2 center = vec2(0.0);
uniform float rotation = 0.0;

uniform bool use_lyapunov = false;
uniform int max_iterations = 500;
uniform float escape_value = 256.0;

uniform vec3 in_set_color = vec3(0);
uniform vec3 far_color = vec3(56, 95, 200);
uniform vec3 close_color = vec3(162, 240, 240);
uniform int amount_of_colors = 30;

vec3 color_getter_le(float lyapunov) {
	// eventually color based on period?
		// my issue with coloring like that is that I've only ever seen
		// images that color the points INSIDE the set as opposed to the
		// "normal" coloring scheme of coloring points OUTSIDE the set
		// like how it's done for positive multibrots
	
	// doesn't work for Re(x) < -1 rn which kinda defeats the purpose sooooooo
	// probably replace lyapunov exponent algorithm with some other periodicity detection?
	
	if (lyapunov <= 0.0) {
		return in_set_color;
	} else {
		return far_color/255.0;
	}
}

vec3 color_getter_et(int cur_iteration) {
	// escape time algorithm really only works "properly" for polynomials
	// i.e. the function actualy *has* an escape radius
	// for that reason, when Re(x) <= 1, the image generated is incorrect
		// this is also true for when Im(x) != 0,
		// but i'll deal with that when i fix the Lyapunov exponent function
	
	vec3 far = far_color/255.0;
	vec3 close = close_color/255.0;

	vec3 color_difference = (close - far)/float(amount_of_colors);
	vec3 cur_color = far;
	
	cur_color += color_difference*float(cur_iteration % amount_of_colors);
	
	return cur_color;
}
