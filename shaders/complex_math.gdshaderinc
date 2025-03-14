// this is where i will house all the complex operations that can be done

vec2 c_multiply(vec2 z1, vec2 z2) {
	return vec2(z1.x*z2.x-z1.y*z2.y, z1.x*z2.y+z1.y*z2.x);
}

vec2 c_power(vec2 z, float power) {
	float r = length(z);
	float theta = atan(z.y,z.x);
	return vec2(r*cos(power*theta),r*sin(power*theta));
	//redo this to do in terms of polar coords
}