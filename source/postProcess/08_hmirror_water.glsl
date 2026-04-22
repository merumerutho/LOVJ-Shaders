// @param float _rippleAmp 0.01 //
// @param float _rippleFreq 0.5 //

extern float _rippleAmp;
extern float _rippleFreq;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    float lr = clamp(sign(texture_coords.y - 0.5), 0.0, 1.0);
    float freq = _rippleFreq * 100.0;
    texture_coords.x = mod(texture_coords.x + lr * _rippleAmp * texture_coords.y * sin(freq * texture_coords.y), 1.0);
    texture_coords.y = texture_coords.y - lr * (2.0 * (texture_coords.y - 0.5));
    return Texel(tex, texture_coords);
}
