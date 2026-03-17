shader_type canvas_item;

uniform vec4 flash_color: source_color = vec4(0.0f);
uniform float flash_range : hint_range(0.0, 1.0) =0.0f;

void fragment()
{
	vec4 origin_color = texture(TEXTURE,UV);
	
	vec4 mix_color = mix(origin_color,flash_color,flash_range);
	
	COLOR = mix_color;
	COLOR.a = origin_color.a;
}