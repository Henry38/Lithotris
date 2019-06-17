shader_type canvas_item;

uniform sampler2D orderTexture;
uniform vec4 lightColor : hint_color;

void fragment(){
	float minA = mod( (TIME / 2.0), 1.2) - 0.2;
	float maxA = minA + 0.3;
	float aIntensity = texture(orderTexture, UV.xy).r;
	float doesLight = float(aIntensity > minA && aIntensity < maxA);
	vec4 inCol = texture(TEXTURE, UV.xy);
	float realIntensity = (inCol.a - minA) / (maxA - minA);
	COLOR = vec4(lightColor.xyz, realIntensity * sign(inCol.a) * doesLight);
}