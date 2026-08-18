extends CharacterBody3D

## Very simple wandering NPC for the vertical slice
## Makes the village feel a little more alive

@export var walk_speed: float = 1.8
@export var wander_radius: float = 8.0
@export var wait_time_min: float = 2.0
@export var wait_time_max: float = 5.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var start_position: Vector3
var target_position: Vector3
var is_waiting: bool = false

func _ready() -> void:
	start_position = global_position
	_pick_new_target()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta

	if is_waiting:
		velocity.x = 0.0
		velocity.z = 0.0
		move_and_slide()
		return

	var direction := (target_position - global_position).normalized()
	direction.y = 0.0

	if global_position.distance_to(target_position) < 0.6:
		_start_wait()
	else:
		velocity.x = direction.x * walk_speed
		velocity.z = direction.z * walk_speed
		# Face movement direction
		if direction != Vector3.ZERO:
			look_at(global_position + direction, Vector3.UP)

	move_and_slide()

func _pick_new_target() -> void:
	var random_offset := Vector3(
		randf_range(-wander_radius, wander_radius),
		0.0,
		randf_range(-wander_radius, wander_radius)
	)
	target_position = start_position + random_offset

func _start_wait() -> void:
	is_waiting = true
	var wait_time := randf_range(wait_time_min, wait_time_max)
	await get_tree().create_timer(wait_time).timeout
	is_waiting = false
	_pick_new_target()
