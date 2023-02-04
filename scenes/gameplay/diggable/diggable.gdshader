shader_type spatial;

uniform sampler2D heightmap;
uniform sampler2D set_height;
uniform sampler2D dirt_tex: hint_default_black;

void vertex() {
	VERTEX.y -= min(texture(heightmap, UV).a, texture(set_height, UV).r) * 0.1;
}

void fragment() {
	// Place fragment code here.
	ALBEDO = texture(dirt_tex, UV).rgb;
}
