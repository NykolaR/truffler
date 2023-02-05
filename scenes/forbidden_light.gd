@tool
extends Node3D

@export var color: Color = Color.WHITE:
	set(new):
		color = new
		if has_node("OmniLight3D"):
			$OmniLight3D.light_color = color
		if has_node("SpotLight3D"):
			$SpotLight3D.light_color = color
