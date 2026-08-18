extends CharacterBody3D

## Olomu Survival - Third Person Player Controller
## Control style: Westland Survival style on mobile
## Left side = Virtual Joystick (movement)
## Right side = Free camera rotation / orbit (drag to look around)
## Optimized for Redmi Note 11 Pro + mid-range Android

@export var walk_speed: float = 4.0
@export var run_speed: float = 6.5
@export var jump_velocity: float = 4.2
@export var mouse_sensitivity: float = 0.003
@export var touch_sensitivity: float = 0.0055   # Tuned for Redmi Note 11 Pro feel
@export var acceleration: float = 12.0
@export var friction: float = 14.0
@export var camera_smoothness: float = 12.0     # Higher = snappier, lower = smoother

@onready var spring_arm: SpringArm3D = $SpringArm3D
@onready var camera: Camera3D = $SpringArm3D/Camera3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_running: bool = false
var mobile_input: Vector2 = Vector2.ZERO
var look_touch_index: int = -1

# For smooth camera
var target_yaw: float = 0.0
var target_pitch: float = 0.0
var current_pitch: float = 0.0

func _ready() -> void:
	add_to_group("player")
	target_yaw = rotation.y
	current_pitch = spring_arm.rotation.x
	target_pitch = current_pitch

	if not OS.has_feature("mobile"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func set_mobile_input(direction: Vector2) -> void:
	mobile_input = direction

func _physics_process(delta: float) -> void:
	# Gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Jump
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity

	# Movement input (keyboard or virtual joystick)
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	if mobile_input != Vector2.ZERO:
		input_dir = mobile_input

	var direction := (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()

	is_running = Input.is_action_pressed("run") or (mobile_input.length() > 0.85)
	var target_speed := run_speed if is_running else walk_speed

	if direction != Vector3.ZERO:
		velocity.x = lerp(velocity.x, direction.x * target_speed, acceleration * delta)
		velocity.z = lerp(velocity.z, direction.z * target_speed, acceleration * delta)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		velocity.z = lerp(velocity.z, 0.0, friction * delta)

	move_and_slide()

	# Smooth camera rotation (Westland-style feel)
	rotation.y = lerp_angle(rotation.y, target_yaw, camera_smoothness * delta)
	current_pitch = lerp(current_pitch, target_pitch, camera_smoothness * delta)
	spring_arm.rotation.x = current_pitch

func _unhandled_input(event: InputEvent) -> void:
	# Desktop mouse look
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_apply_look(event.relative)

	# Mobile: Right half of screen = free camera rotation (Westland style)
	if event is InputEventScreenTouch:
		if event.pressed and event.position.x > get_viewport().get_visible_rect().size.x * 0.45:
			look_touch_index = event.index
		elif not event.pressed and event.index == look_touch_index:
			look_touch_index = -1

	if event is InputEventScreenDrag and event.index == look_touch_index:
		_apply_look(event.relative)

	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED)

func _apply_look(relative: Vector2) -> void:
	# Horizontal rotation (player turns)
	target_yaw -= relative.x * touch_sensitivity

	# Vertical rotation (camera pitch)
	target_pitch -= relative.y * touch_sensitivity
	target_pitch = clamp(target_pitch, deg_to_rad(-55.0), deg_to_rad(25.0))
