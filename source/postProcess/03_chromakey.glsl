// @param float _chromaHue 0.33 //
// @param float _chromaTolerance 0.1 //
// @param float _chromaSoftness 0.05 //

extern float _chromaHue;
extern float _chromaTolerance;
extern float _chromaSoftness;

vec3 rgb2hsv(vec3 c) {
    vec4 K = vec4(0.0, -1.0/3.0, 2.0/3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec4 texColor = Texel(tex, texture_coords);
    vec3 hsv = rgb2hsv(texColor.rgb);

    // Circular hue distance (wraps around 0/1 boundary)
    float hueDist = abs(hsv.x - _chromaHue);
    hueDist = min(hueDist, 1.0 - hueDist);

    // Weight by saturation so grays/whites are never keyed out
    float dist = hueDist * hsv.y;

    float alpha = smoothstep(_chromaTolerance, _chromaTolerance + _chromaSoftness, dist);
    texColor.a = alpha;
    return texColor;
}
