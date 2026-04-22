// @param float _pixres 64 //
extern float _pixres;
vec4 effect( vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords )
{
	float res = max(_pixres, 2.0);
	vec2 distortedUv = floor(texture_coords * res) / res;
	return vec4(Texel(tex, distortedUv));
}