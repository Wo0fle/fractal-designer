// this is where i will house all the complex operations that can be done
// i^2=-1

// basis vectors: i and 1
const vec2 i_vec = vec2(0.0,1.0);
const vec2 one_vec = vec2(1.0,0.0);

// arithmetic:
vec2 c_multiply(vec2 z1, vec2 z2) {
	return vec2(z1.x*z2.x-z1.y*z2.y, z1.x*z2.y+z1.y*z2.x);
}

vec2 c_reciprocal(vec2 z) {
	return vec2(z.x/(pow(length(z),2)), -z.y/(pow(length(z),2)));
}

vec2 c_divide(vec2 z1, vec2 z2) {
	return vec2((z1.x*z2.x+z1.y*z2.y)/(pow(length(z2),2)),(z1.y*z2.x-z1.x*z2.y)/(pow(length(z2),2)));
	//return c_multiply(z1,c_reciprocal(z2));
}

vec2 c_conjugate(vec2 z) {
	return vec2(z.x, -z.y);
}

// root?

// elementary functions (principal values only):
vec2 c_exp(vec2 z) {
	return exp(z.x)*vec2(cos(z.y), sin(z.y));
}

vec2 c_sin(vec2 z) {
	return c_divide(c_exp(c_multiply(i_vec,z))-c_exp(c_multiply(-i_vec,z)),2.0*i_vec);
}

vec2 c_cos(vec2 z) {
	return (c_exp(c_multiply(i_vec,z))+c_exp(c_multiply(-i_vec,z)))/2.0;
}

vec2 c_tan(vec2 z) {
	return c_divide(c_sin(z),c_cos(z));
}

// inverse trig?

vec2 c_sinh(vec2 z) {
	return (c_exp(z)-c_exp(-z))/2.0;
}

vec2 c_cosh(vec2 z) {
	return (c_exp(z)+c_exp(-z))/2.0;
}

vec2 c_tanh(vec2 z) {
	return c_divide(c_sinh(z),c_cosh(z));
}

// inverse hyperbolics?

vec2 c_log(vec2 z) {
	float r = length(z);
	float theta = atan(z.y,z.x);
	return vec2(log(r), theta);
}

vec2 c_pow(vec2 z1, vec2 z2) {
	return c_exp(c_multiply(z2,c_log(z1)));
}