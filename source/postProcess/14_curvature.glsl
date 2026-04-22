// @param float _curvature 0.5 //
// @param float _offsetY 0.5 //

extern float _curvature;
extern float _offsetY;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = texture_coords;
    float strength = _curvature * 2.0;
    uv.y = pow(abs(uv.y - _offsetY), max(strength, 0.1)) + (1.0 - _offsetY) * (1.0 - strength);
    return Texel(tex, uv);
}
