// @param float _strength 0.02 //
// @param float _angle 0.0 //
// @param float _center 0.0 //

extern float _strength;
extern float _angle;
extern float _center;

const int SAMPLES = 16;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    float radial = _center;
    float directional = 1.0 - _center;

    vec2 dirOffset = vec2(cos(_angle), sin(_angle)) * _strength * directional;

    vec2 fromCenter = texture_coords - vec2(0.5);
    vec2 radOffset = fromCenter * _strength * 2.0 * radial;

    vec2 offset = dirOffset + radOffset;

    vec4 sum = vec4(0.0);
    for (int i = 0; i < SAMPLES; i++)
    {
        float t = (float(i) / float(SAMPLES - 1)) - 0.5;
        vec2 uv = texture_coords + offset * t;
        sum += Texel(tex, clamp(uv, 0.0, 1.0));
    }
    return sum / float(SAMPLES);
}
