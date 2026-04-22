// @param float _cutSize 0.2 //

extern float _cutSize;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 new_coords = texture_coords - mod(texture_coords.y + texture_coords.x, max(_cutSize, 0.01));
    return Texel(tex, new_coords);
}
