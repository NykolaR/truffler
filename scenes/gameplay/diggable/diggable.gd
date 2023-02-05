extends Node3D


var nose: Node3D = null

@onready var dig_sprite: Sprite2D = $SubViewport/Sprite2D as Sprite2D
@onready var viewport: SubViewport = $SubViewport as SubViewport

var flag = false

func _ready() -> void:
	viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
	
	
func _physics_process(delta: float) -> void:
	if not flag:
		var ray: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(global_position, global_position + Vector3.DOWN * 100)
		flag = true
		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(ray)
		global_position = result.position
		global_position.y -= .25
		#global_transform.basis.y = Vector3(1,1,1).normalized()
		
	if nose:
		var local_pos: Vector3 = to_local(nose.global_transform.origin)
		var pos2d: Vector2 = Vector2(local_pos.x, local_pos.z)
		pos2d.x = remap(pos2d.x, -0.5, 0.5, 0, 128)
		pos2d.y = remap(pos2d.y, -0.5, 0.5, 0, 128)
		dig_sprite.position = pos2d
		dig_sprite.self_modulate.a = clamp(remap(local_pos.y, 0.25, 0.5, 1.5, 0), 0, 1.5)
	else:
		dig_sprite.self_modulate.a = 0.0

func _on_area_3d_area_entered(area: Area3D) -> void:
	if not nose:
		nose = area

func _on_area_3d_area_exited(area: Area3D) -> void:
	if nose == area:
		nose = null
