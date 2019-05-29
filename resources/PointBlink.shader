shader_type canvas_item;

void fragment(){
	COLOR = texture(TEXTURE, UV) * (2.0 * (sin(TIME) / 2.0 + 1.0));	
}