shader_type canvas_item;

uniform sampler2D orderTexture;
uniform vec4 lightColor : hint_color;

void fragment(){
	float minA = mod( (TIME / 2.0), 1.2) - 0.4;
	float maxA = minA + 0.5;
	float aIntensity = texture(orderTexture, UV.xy).r;
	float doesLight = float(aIntensity > minA && aIntensity < maxA);
	vec4 inCol = texture(TEXTURE, UV.xy);
	float atBorder = float(UV.x <= 0.05 || UV.y <= 0.05 || UV.x >= 0.95 || UV.y >= 0.95);
	
	float realIntensity = (inCol.a - minA) / (maxA - minA);
	COLOR = vec4(lightColor.xyz, max(atBorder, sign(inCol.a) * realIntensity * doesLight));
}