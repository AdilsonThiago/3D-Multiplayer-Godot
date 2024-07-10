extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var sensibilidade = 0.4

@onready var maquinaEstados = $AnimationTree["parameters/playback"]

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _enter_tree():
	set_multiplayer_authority(name.to_int())
	$SpringArm3D/Camera3D.current = is_multiplayer_authority()
	pass

func _input(event):
	if (event is InputEventMouseMotion) and is_multiplayer_authority():
		rotate_y(-deg_to_rad(event.relative.x) * sensibilidade)
		$SpringArm3D.rotate_x(deg_to_rad(event.relative.y) * sensibilidade)
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	pass

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Vector3.ZERO
	if is_multiplayer_authority():
		input_dir = -Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		$RobotArmature.look_at(position - direction)
		$AnimationTree["parameters/Normal/blend_position"] = 1.0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		$AnimationTree["parameters/Normal/blend_position"] = 0.0

	move_and_slide()
	pass
