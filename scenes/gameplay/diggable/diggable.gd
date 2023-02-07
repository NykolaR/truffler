extends Node3D


var nose: Node3D = null

@onready var dig_sprite: Sprite2D = $SubViewport/Sprite2D as Sprite2D
@onready var viewport: SubViewport = $SubViewport as SubViewport

var flag = false

func _ready() -> void:
	$Node3D/MeshInstance3D2.material_override.shader = $Node3D/MeshInstance3D2.material_override.shader.duplicate()
	#set_physics_process(false)
	await get_tree().create_timer(0.5).timeout
	
	viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_NEVER
	viewport.render_target_update_mode = SubViewport.UPDATE_DISABLED

func _physics_process(delta: float) -> void:
	if not flag:
		var ray: PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.create(global_position, global_position + Vector3.DOWN * 100)
		flag = true
		var space_state = get_world_3d().direct_space_state
		var result = space_state.intersect_ray(ray)
		
		if not result.is_empty():
			global_position = result.position
			#global_position.y -= .25
			#global_transform.basis = Basis.from_euler(result.normal, 5) # 0-5
			if not Vector3.UP.dot(result.normal) == 1.0:
				look_at(global_position + result.normal, Vector3.UP)
			else:
				rotation_degrees.x += 90
			global_position.y -= 0.15
		set_physics_process(false)
		return
	
	if nose:
		var local_pos: Vector3 = to_local(nose.global_transform.origin)
		var pos2d: Vector2 = Vector2(local_pos.x, local_pos.y)
		pos2d.x = remap(pos2d.x, -0.5, 0.5, 0, 128)
		pos2d.y = remap(pos2d.y, -0.5, 0.5, 0, 128)
		dig_sprite.position = pos2d
		dig_sprite.self_modulate.a = clamp(remap(local_pos.z, 0.2, -0.2, 1, 0), 0, 1)
	else:
		dig_sprite.self_modulate.a = 0.0
	
	viewport.render_target_update_mode = SubViewport.UPDATE_ONCE

func _on_area_3d_area_entered(area: Area3D) -> void:
	if not nose:
		nose = area
		set_physics_process(true)

func _on_area_3d_area_exited(area: Area3D) -> void:
	if nose == area:
		nose = null
		set_physics_process(false)
