extends Node

## Simple Game Manager / Autoload helper
## Helps connect systems together easily

var player: Node = null
var survival: Node = null
var inventory: Node = null
var save_system: Node = null

func register_player(p: Node) -> void:
	player = p
	survival = p.get_node_or_null("SurvivalNeeds")
	inventory = p.get_node_or_null("Inventory")
	print("Player registered in GameManager")

func register_save_system(s: Node) -> void:
	save_system = s

func save_game() -> void:
	if save_system and player and survival and inventory:
		save_system.save_game(player, survival, inventory)

func load_game() -> void:
	if save_system and player and survival and inventory:
		save_system.load_game(player, survival, inventory)
