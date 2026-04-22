// @param float _time 0 //
// @param float _cycles 0.25 //
// @param float _chunkW 0.3 //
// @param float _chunkH 0.5 //
// @param float _speed 1.0 //

extern float _time;
extern float _cycles;
extern float _chunkW;
extern float _chunkH;
extern float _speed;

float random(vec2 st) {
    return fract(sin(dot(st.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords) {
    vec2 uv = texture_coords;
    float seed = floor(_time * _speed);
    int numCycles = int(_cycles * 100.0);

    for (int i = 0; i < numCycles; i++) {
        float fi = float(i);
        float r1 = random(vec2(seed * 0.1, fi * 0.2));
        float r2 = random(vec2(seed * 0.3, fi * 0.4));
        float r3 = random(vec2(seed * 0.5, fi * 0.6));
        float r4 = random(vec2(seed * 0.7, fi * 0.8));

        vec2 src_pos = vec2(r1, r2);
        vec2 src_max = src_pos + vec2(_chunkW, _chunkH);
        vec2 dest_offset = vec2(r3, r4) - src_pos;

        float mask = step(src_pos.x, uv.x) * (1.0 - step(src_max.x, uv.x))
                   * step(src_pos.y, uv.y) * (1.0 - step(src_max.y, uv.y));

        uv += dest_offset * mask;
    }

    return Texel(tex, clamp(uv, 0.0, 1.0));
}
