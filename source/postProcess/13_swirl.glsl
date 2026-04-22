// @param float _time 0 //
// @param float _swirlAmount 0.5 //
// @param float _swirlSpeed 0.2 //

extern float _time;
extern float _swirlAmount;
extern float _swirlSpeed;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = texture_coords;
    vec2 center = vec2(0.5, 0.5);

    vec2 delta = uv - center;
    float dist = length(delta);
    float angle = atan(delta.y, delta.x);

    float amount = _swirlAmount * 20.0 * sin(_time * _swirlSpeed * 10.0) + _swirlAmount * 20.0;
    float swirlAngle = amount * dist;

    vec2 distortedUV = center + 0.707 * vec2(cos(angle + swirlAngle), sin(angle + swirlAngle)) * dist;

    return Texel(tex, distortedUV);
}
