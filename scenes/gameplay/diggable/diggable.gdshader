shader_type spatial;
render_mode cull_disabled;

uniform sampler2D heightmap;
uniform sampler2D set_height;
uniform sampler2D dirt_tex: hint_default_black;

void vertex() {
	VERTEX.y -= min(texture(heightmap, UV * 0.9).a, texture(set_height, UV).r) * 0.2;
}

void fragment() {
	// Place fragment code here.
	ALBEDO = texture(dirt_tex, UV).rgb;
}
