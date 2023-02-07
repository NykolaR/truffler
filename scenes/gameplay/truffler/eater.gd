extends Area3D

var eat_l: bool = true
var truff: Node3D = null

@onready var eating: CanvasLayer = $Eating as CanvasLayer
@onready var l_label: Label = $Eating/Left as Label
@onready var r_label: Label = $Eating/Right as Label
@onready var eat_audio: AudioStreamPlayer = $Eating/AudioStreamPlayer as AudioStreamPlayer

func _ready() -> void:
	set_process_input(false)


func _input(event: InputEvent) -> void:
	if eat_l and event.is_action_pressed("eat_l"):
		eat_l = not eat_l
		l_label.visible = false
		r_label.visible = true
		truff.scale -= Vector3(0.1, 0.1, 0.1)
		var tween: Tween = get_tree().create_tween()
		eat_audio.volume_db = 0.0
		tween.tween_property(eat_audio, "volume_db", -80.0, 10.0)
		if truff.scale.length_squared() < 0.1:
			truff.get_parent().queue_free()
			_on_area_exited(null)
			$AudioStreamPlayer.play()
	if not eat_l and event.is_action_pressed("eat_r"):
		eat_l = not eat_l
		l_label.visible = true
		r_label.visible = false
		truff.scale -= Vector3(0.1, 0.1, 0.1)
		var tween: Tween = get_tree().create_tween()
		eat_audio.volume_db = 0.0
		tween.tween_property(eat_audio, "volume_db", -80.0, 10.0)
		if truff.scale.is_equal_approx(Vector3.ZERO):
			truff.get_parent().queue_free()
			_on_area_exited(null)
			$AudioStreamPlayer.play()


func _on_area_entered(area: Area3D) -> void:
	truff = area.get_node("MeshInstance3D")
	set_process_input(true)
	eating.visible = true


func _on_area_exited(area: Area3D) -> void:
	if not area or truff == area.get_node("MeshInstance3D"):
		truff = null
		set_process_input(false)
		eating.visible = false
