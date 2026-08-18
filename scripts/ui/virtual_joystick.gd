extends Control

## Simple, lightweight virtual joystick for mid-range Android
## Optimized for performance and good touch feel on common phones

signal joystick_input(direction: Vector2)

@export var radius: float = 80.0
@export var deadzone: float = 0.2
@export var follow_finger: bool = true

var is_active: bool = false
var touch_index: int = -1
var center: Vector2 = Vector2.ZERO
var current_direction: Vector2 = Vector2.ZERO
var knob_position: Vector2 = Vector2.ZERO

func _ready() -> void:
	hide()
	set_process(false)

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		_handle_touch(event)
	elif event is InputEventScreenDrag and event.index == touch_index:
		_handle_drag(event)

func _handle_touch(event: InputEventScreenTouch) -> void:
	if event.pressed:
		if event.position.x < get_viewport_rect().size.x * 0.5:
			is_active = true
			touch_index = event.index
			center = event.position
			knob_position = Vector2.ZERO
			current_direction = Vector2.ZERO
			show()
			set_process(true)
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
		current_direction = current_direction.normalized() * ((current_direction.length() - deadzone) / (1.0 - deadzone))

	joystick_input.emit(current_direction)
	queue_redraw()

func _reset() -> void:
	is_active = false
	touch_index = -1
	current_direction = Vector2.ZERO
	knob_position = Vector2.ZERO
	joystick_input.emit(Vector2.ZERO)
	hide()
	set_process(false)
	queue_redraw()

func _draw() -> void:
	if not is_active:
		return
	draw_circle(center, radius, Color(1, 1, 1, 0.15))
	draw_arc(center, radius, 0, TAU, 32, Color(1, 1, 1, 0.4), 2.0)
	draw_circle(center + knob_position, radius * 0.35, Color(1, 1, 1, 0.7))

func get_direction() -> Vector2:
	return current_direction
