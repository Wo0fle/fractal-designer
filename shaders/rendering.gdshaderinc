uniform int var_on_pixels = 0;

uniform float zoom = 4.0;
uniform vec2 center = vec2(0.0);
uniform float rotation = 0.0;

uniform bool use_period_coloring = false;
uniform int max_period = 50;
uniform float tolerance = 0.0001;

uniform bool use_escape_time_coloring = true;
uniform float escape_value = 256.0;

uniform int max_iterations = 500;

uniform vec3 in_set_color = vec3(0);
uniform vec3 far_color = vec3(56, 95, 200);
uniform vec3 close_color = vec3(162, 240, 240);
uniform int amount_of_colors = 30;

vec3 color_getter_period(int period) {
	// color based on the period
	return vec3(0);
}

vec3 color_getter_escape_time(int cur_iteration) {
	// escape time algorithm technically only works "properly" for polynomials
	// i.e. the function actualy *has* an escape radius
	// for that reason, when Re(x) <= 1, the image generated is technically inaccurate
	// this is also true for when Im(x) != 0,
	// however, with a big enough escape radius, it looks fine

	vec3 far = far_color/255.0;
	vec3 close = close_color/255.0;

	vec3 color_difference = (close - far)/float(amount_of_colors);
	vec3 cur_color = far;

	cur_color += color_difference*float(cur_iteration % amount_of_colors);

	return cur_color;
}
