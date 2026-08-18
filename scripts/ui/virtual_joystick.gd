extends Control

## Lightweight virtual joystick - Westland Survival style
## Only appears on left side of screen
## Optimized for Redmi Note 11 Pro

signal joystick_input(direction: Vector2)

@export var radius: float = 90.0
@export var deadzone: float = 0.18
@export var follow_finger: bool = true

var is_active: bool = false
var touch_index: int = -1
var center: Vector2 = Vector2.ZERO
var current_direction: Vector2 = Vector2.ZERO
var knob_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	hide()
	mouse_filter = Control.MOUSE_FILTER_IGNORE

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		_handle_touch(event)
	elif event is InputEventScreenDrag and event.index == touch_index:
		_handle_drag(event)

func _handle_touch(event: InputEventScreenTouch) -> void:
	if event.pressed:
		# Left 45% of screen for movement
		if event.position.x < get_viewport_rect().size.x * 0.45:
			is_active = true
			touch_index = event.index
			center = event.position
			knob_position = Vector2.ZERO
			current_direction = Vector2.ZERO
			show()
			queue_redraw()
	else:
		if event.index == touch_index:
			_reset()

func _handle_drag(event: InputEventScreenDrag) -> void:
	if not is_active:
		return

	var offset := event.position - center
	var distance := offset.length()

	if distance > radius:
		offset = offset.normalized() * radius
		if follow_finger:
			center = event.position - offset

	knob_position = offset
	current_direction = offset / radius

	if current_direction.length() < deadzone:
		current_direction = Vector2.ZERO
	else:
		var len := current_direction.length()
		current_direction = current_direction.normalized() * ((len - deadzone) / (1.0 - deadzone))

	joystick_input.emit(current_direction)
	queue_redraw()

func _reset() -> void:
	is_active = false
	touch_index = -1
	current_direction = Vector2.ZERO
	knob_position = Vector2.ZERO
	joystick_input.emit(Vector2.ZERO)
	hide()
	queue_redraw()

func _draw() -> void:
	if not is_active:
		return

	# Soft base
	draw_circle(center, radius, Color(1, 1, 1, 0.12))
	draw_arc(center, radius, 0, TAU, 48, Color(1, 1, 1, 0.35), 2.5)

	# Knob
	draw_circle(center + knob_position, radius * 0.38, Color(1, 1, 1, 0.65))

func get_direction() -> Vector2:
	return current_direction
