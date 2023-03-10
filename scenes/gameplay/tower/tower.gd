extends Node3D

@onready var light: Node3D = $Area3D/ForbiddenLight as Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	$AudioStreamPlayer3D.play()
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(light, "color", Color.RED, 1.0)
	tween.tween_property($AnimationPlayer, "speed_scale", 0.0, 0.4)


func _on_area_3d_body_exited(body: Node3D) -> void:
	$AudioStreamPlayer3D.play()
	var tween: Tween = get_tree().create_tween()
	tween.set_parallel(true)
	tween.tween_property(light, "color", Color(0.98431372642517, 0.86666667461395, 0.76078432798386), 1.0)
	tween.tween_property($AnimationPlayer, "speed_scale", 0.5, 0.4)
