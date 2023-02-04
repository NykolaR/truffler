extends Node3D


@onready var viewport: SubViewport = $SubViewport as SubViewport


func _process(delta: float) -> void:
	viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
