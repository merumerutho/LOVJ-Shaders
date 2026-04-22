// @param float _scanIntensity 0.3 //
// @param float _curvature 0.2 //
// @param float _vignette 0.4 //
// @param float _chromaShift 0.003 //
// @param float _brightness 1.1 //
// @param float _scanCount 0.5 //

extern float _scanIntensity;
extern float _curvature;
extern float _vignette;
extern float _chromaShift;
extern float _brightness;
extern float _scanCount;

vec2 curveUV(vec2 uv) {
    uv = uv * 2.0 - 1.0;
    uv *= 1.0 + dot(uv, uv) * _curvature;
    return uv * 0.5 + 0.5;
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = curveUV(texture_coords);

    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0)
        return vec4(0.0, 0.0, 0.0, 1.0);

    float r = Texel(tex, vec2(uv.x + _chromaShift, uv.y)).r;
    float g = Texel(tex, uv).g;
    float b = Texel(tex, vec2(uv.x - _chromaShift, uv.y)).b;
    vec3 col = vec3(r, g, b);

    float lines = 300.0 + _scanCount * 600.0;
    float scanline = sin(uv.y * lines * 3.14159) * 0.5 + 0.5;
    scanline = mix(1.0, scanline, _scanIntensity);
    col *= scanline;

    col *= _brightness;

    vec2 vig = uv * (1.0 - uv);
    float v = pow(vig.x * vig.y * 16.0, _vignette * 0.5);
    col *= v;

    return vec4(col, 1.0);
}
