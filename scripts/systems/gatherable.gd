extends Area3D

## Simple gatherable item for Olomu vertical slice
## Attach to any prop (wood, plant, stone, food, etc.)

@export var item_name: String = "wood"
@export var amount: int = 1
@export var gather_time: float = 0.8
@export var destroy_on_gather: bool = true

signal gathered(item_name: String, amount: int)

var is_gathering: bool = false
var player_in_range: Node = null

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("player"):
		player_in_range = body

func _on_body_exited(body: Node3D) -> void:
	if body == player_in_range:
		player_in_range = null

func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact") and not is_gathering:
		_start_gather()

func _start_gather() -> void:
	is_gathering = true
	print("Gathering ", item_name, "...")
	await get_tree().create_timer(gather_time).timeout

	# Try to give item to player inventory
	var inventory = player_in_range.get_node_or_null("Inventory")
	if inventory and inventory.has_method("add_item"):
		inventory.add_item(item_name, amount)

	gathered.emit(item_name, amount)
	print("Gathered ", amount, " ", item_name)

	if destroy_on_gather:
		queue_free()
	else:
		is_gathering = false
