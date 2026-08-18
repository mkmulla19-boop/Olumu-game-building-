extends Control

## Simple pause menu for mobile

@onready var resume_btn: Button = $Panel/ResumeButton
@onready var save_btn: Button = $Panel/SaveButton
@onready var load_btn: Button = $Panel/LoadButton

var is_paused: bool = false
var save_system: Node = null
var player: Node = null
var survival: Node = null
var inventory: Node = null

func _ready() -> void:
	hide()
	process_mode = Node.PROCESS_MODE_ALWAYS

	if resume_btn:
		resume_btn.pressed.connect(resume)
	if save_btn:
		save_btn.pressed.connect(_on_save)
	if load_btn:
		load_btn.pressed.connect(_on_load)

func setup(p: Node, s: Node, inv: Node, save_node: Node) -> void:
	player = p
	survival = s
	inventory = inv
	save_system = save_node

func toggle() -> void:
	if is_paused:
		resume()
	else:
		pause()

func pause() -> void:
	is_paused = true
	get_tree().paused = true
	show()

func resume() -> void:
	is_paused = false
	get_tree().paused = false
	hide()

func _on_save() -> void:
	if save_system and player and survival and inventory:
		save_system.save_game(player, survival, inventory)

func _on_load() -> void:
	if save_system and player and survival and inventory:
		save_system.load_game(player, survival, inventory)
		resume()
