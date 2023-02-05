extends CharacterBody3D


const SPEED: float = 1.0
const JUMP_VELOCITY: float = 4.5
const LOOK_CONSTRAINT_UP: float = 40.0
const LOOK_CONSTRAINT_DOWN: float = 75.0

var sense: float = 5.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var camera: Node3D = $Node3D as Node3D
@onready var oinks: Array = $Oinks.get_children() as Array
@onready var smellovision: GPUParticles3D = $Node3D/Smellovision as GPUParticles3D
@onready var sniff_player: AudioStreamPlayer = $Sniff as AudioStreamPlayer
@onready var walkies: AudioStreamPlayer = $Walkies as AudioStreamPlayer

func _input(event: InputEvent) -> void:
	if event.is_action("oink"):
		oinks[randi()%oinks.size()].play()


func _physics_process(delta: float):
	_camera(delta)
	_movement(delta)
	walkies.volume_db = clamp(linear_to_db(clamp(velocity.length_squared()/3.0, 0.0, 1.0)), -80.0, -3.0)
	move_and_slide()
	
	if not smellovision.emitting == Input.is_action_pressed("smelly"):
		smellovision.emitting = Input.is_action_pressed("smelly")
		var tween: Tween = get_tree().create_tween()
		if smellovision.emitting:
			tween.tween_property(sniff_player, "volume_db", 0.0, 0.5)
		else:
			tween.tween_property(sniff_player, "volume_db", -80.0, 0.5)

func _camera(delta: float) -> void:
	var input_dir: Vector2 = Input.get_vector("look_left", "look_right", "look_up", "look_down")
	# if input type is mouse, get mouse input and overwrite
	var intensity: float = clamp(input_dir.length(), 0, 1)
	
	rotate_y(-input_dir.x * delta * sense)
	camera.rotate_x(-input_dir.y * delta * sense)
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -LOOK_CONSTRAINT_DOWN, LOOK_CONSTRAINT_UP)


func _movement(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir: Vector2 = Input.get_vector("left", "right", "up", "down")
	var intensity: float = clamp(input_dir.length(), 0, 1)
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() * intensity
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
