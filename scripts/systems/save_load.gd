extends Node

## Basic save / load system for Olomu Survival
## Saves player position + survival needs + inventory

const SAVE_PATH := "user://olomu_save.json"

func save_game(player: Node3D, survival: Node, inventory: Node) -> void:
	var data := {
		"position": {
			"x": player.global_position.x,
			"y": player.global_position.y,
			"z": player.global_position.z
		},
		"hunger": survival.hunger,
		"thirst": survival.thirst,
		"inventory": inventory.get_all_items()
	}

	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
		print("Game saved.")
	else:
		print("Failed to save game.")

func load_game(player: Node3D, survival: Node, inventory: Node) -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		print("No save file found.")
		return false

	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if not file:
		return false

	var json := JSON.new()
	var error := json.parse(file.get_as_text())
	file.close()

	if error != OK:
		print("Failed to parse save file.")
		return false

	var data: Dictionary = json.data

	if data.has("position"):
		var pos = data["position"]
		player.global_position = Vector3(pos["x"], pos["y"], pos["z"])

	if data.has("hunger"):
		survival.hunger = data["hunger"]
	if data.has("thirst"):
		survival.thirst = data["thirst"]

	if data.has("inventory"):
		inventory.items = data["inventory"]
		inventory.inventory_changed.emit()

	print("Game loaded.")
	return true
