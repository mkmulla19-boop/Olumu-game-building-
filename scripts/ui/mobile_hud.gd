extends CanvasLayer

## Mobile HUD for Olomu Survival
## Westland Survival style controls + survival bars
## Optimized for Redmi Note 11 Pro

@onready var joystick: Control = $VirtualJoystick
@onready var jump_btn: TouchScreenButton = $Buttons/JumpButton
@onready var interact_btn: TouchScreenButton = $Buttons/InteractButton
@onready var hunger_bar: ProgressBar = $SurvivalBars/HungerBar
@onready var thirst_bar: ProgressBar = $SurvivalBars/ThirstBar

var player: Node = null
var survival: Node = null

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

	if player:
		survival = player.get_node_or_null("SurvivalNeeds")

	# Connect joystick
	if joystick and joystick.has_signal("joystick_input"):
		joystick.joystick_input.connect(_on_joystick_input)

	# Jump button
	if jump_btn:
		jump_btn.pressed.connect(_on_jump_pressed)

	# Interact button
	if interact_btn:
		interact_btn.pressed.connect(_on_interact_pressed)

func _process(_delta: float) -> void:
	if survival:
		if hunger_bar:
			hunger_bar.value = survival.hunger
		if thirst_bar:
			thirst_bar.value = survival.thirst

func _on_joystick_input(direction: Vector2) -> void:
	if player and player.has_method("set_mobile_input"):
		player.set_mobile_input(direction)

func _on_jump_pressed() -> void:
	if player and player.has_method("request_jump"):
		player.request_jump()
	# Fallback: simulate jump action
	Input.action_press("jump")
	await get_tree().create_timer(0.1).timeout
	Input.action_release("jump")

func _on_interact_pressed() -> void:
	Input.action_press("interact")
	await get_tree().create_timer(0.1).timeout
	Input.action_release("interact")
