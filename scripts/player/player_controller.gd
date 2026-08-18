extends CharacterBody3D

## Olomu Survival - Third Person Player Controller
## Godot 4.7.1 | Android-first design
## Basic touch support included. Fine-tuning on real device still required.

@export var walk_speed: float = 4.0
@export var run_speed: float = 7.0
@export var jump_velocity: float = 4.5
@export var mouse_sensitivity: float = 0.003
@export var touch_sensitivity: float = 0.007
@export var acceleration: float = 10.0
@export var friction: float = 12.0

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var camera: Camera3D = $SpringArm3D/Camera3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_running: bool = false
var input_dir: Vector2 = Vector2.ZERO

func _ready() -> void:
	# Keep mouse captured for desktop testing
	if OS.has_feature("mobile") == false:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get input (keyboard + future virtual joystick)
	input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()

	is_running = Input.is_action_pressed("run")
	var target_speed := run_speed if is_running else walk_speed

	if direction != Vector3.ZERO:
		velocity.x = lerp(velocity.x, direction.x * target_speed, acceleration * delta)
		velocity.z = lerp(velocity.z, direction.z * target_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		velocity.z = lerp(velocity.z, 0.0, friction * delta)

	move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	# Desktop mouse look
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_rotate_camera(event.relative)

	# Basic touch look (right side of screen recommended for virtual stick later)
	if event is InputEventScreenDrag:
		_rotate_camera(event.relative * (touch_sensitivity / mouse_sensitivity))

	# Toggle mouse capture (desktop)
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _rotate_camera(relative: Vector2) -> void:
	rotate_y(-relative.x * mouse_sensitivity)
	spring_arm.rotate_x(-relative.y * mouse_sensitivity)
	spring_arm.rotation.x = clamp(spring_arm.rotation.x, deg_to_rad(-55.0), deg_to_rad(25.0))
