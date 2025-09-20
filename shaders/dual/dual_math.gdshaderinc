// this is where i will house all the dual number operations that can be done
// epsilon^2=0, epsilon/=0

// basis vectors: epsilon and 1
const vec2 epsilon_vec = vec2(0.0,1.0);
const vec2 one_vec = vec2(1.0,0.0);

// arithmetic:
vec2 d_multiply(vec2 z1, vec2 z2) {
	return vec2(z1.x*z2.x, z1.x*z2.y+z1.y*z2.x);
}

vec2 d_reciprocal(vec2 z) {
	return vec2(1.0/z.x,-z.y/pow(z.x,2));
}

vec2 d_divide(vec2 z1, vec2 z2) {
	return vec2(z1.x/z2.x,(z1.y*z2.x-z1.x*z2.y)/pow(z2.x,2));
	//return d_multiply(z1,d_reciprocal(z2));
}

vec2 d_conjugate(vec2 z) {
	return vec2(z.x,-z.y);
}

/*

// root?

// elementary functions (principal values only):
vec2 d_exp(vec2 z) {
	return exp(z.x)*vec2(cos(z.y), sin(z.y));
}

vec2 d_sin(vec2 z) {
	return d_divide(d_exp(d_multiply(epsilon_vec,z))-d_exp(d_multiply(-epsilon_vec,z)),2.0*epsilon_vec);
}

vec2 d_cos(vec2 z) {
	return (d_exp(d_multiply(epsilon_vec,z))+d_exp(d_multiply(-epsilon_vec,z)))/2.0;
}

vec2 d_tan(vec2 z) {
	return d_divide(d_sin(z),d_cos(z));
}

// inverse trig?

vec2 d_sinh(vec2 z) {
	return (d_exp(z)-d_exp(-z))/2.0;
}

vec2 d_cosh(vec2 z) {
	return (d_exp(z)+d_exp(-z))/2.0;
}

vec2 d_tanh(vec2 z) {
	return d_divide(d_sinh(z),d_cosh(z));
}

// inverse hyperbolics?

vec2 d_log(vec2 z) {
	float r = length(z);
	float theta = atan(z.y,z.x);
	return vec2(log(r), theta);
}

vec2 d_pow(vec2 z1, vec2 z2) {
	return d_exp(d_multiply(z2,d_log(z1)));
}
*/