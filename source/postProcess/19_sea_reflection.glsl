// @param float _time 0 //
// @param float _waveAmp 0.01 //
// @param float _waveFreq 0.1 //
// @param float _waveSpeed 0.2 //
// @param float _splitY 0.5 //

extern float _time;
extern float _waveAmp;
extern float _waveFreq;
extern float _waveSpeed;
extern float _splitY;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = texture_coords;
    float reflection_mask = step(_splitY, uv.y);

    float flipped_y = 2.0 * _splitY - uv.y;
    uv.y = mix(uv.y, flipped_y, reflection_mask);

    float freq = _waveFreq * 100.0;
    float speed = _waveSpeed * 10.0;
    float distortion = sin(uv.y * freq + _time * speed) * _waveAmp;
    uv.x += distortion * reflection_mask;

    return Texel(tex, uv);
}
