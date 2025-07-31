shader_type canvas_item;

uniform float radius;

void fragment() {
	if(pow(UV.x - 0.5 ,2) + pow(UV.y - 0.5, 2) < pow(radius, 2)){
		COLOR.a = 0.0;
	}
}
