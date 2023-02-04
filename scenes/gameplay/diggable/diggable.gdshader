shader_type spatial;

uniform sampler2D heightmap;
uniform sampler2D dirt_tex: hint_default_black;

void vertex() {
	VERTEX.y -= texture(heightmap, UV).a * 0.4;
}

void fragment() {
	// Place fragment code here.
	ALBEDO = texture(dirt_tex, UV).rgb;
}
