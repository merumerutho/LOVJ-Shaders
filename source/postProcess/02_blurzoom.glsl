// @param float _zoomAmount 0.5 //
// @param float _mixRatio 0.35 //

extern float _zoomAmount;
extern float _mixRatio;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    float half_zoom = _zoomAmount * 0.5;
    vec2 zoomed_coords = texture_coords * (1.0 - _zoomAmount) + half_zoom;
    vec4 original = Texel(tex, texture_coords);
    vec4 zoomed = Texel(tex, zoomed_coords);
    return mix(original, zoomed, _mixRatio);
}
