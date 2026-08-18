extends Node

## Very simple inventory for the vertical slice
## Can be expanded later without rewriting everything

signal inventory_changed

var items: Dictionary = {}  # item_name -> quantity

func add_item(item_name: String, amount: int = 1) -> void:
	if items.has(item_name):
		items[item_name] += amount
	else:
		items[item_name] = amount
	inventory_changed.emit()
	print("Added ", amount, " ", item_name)

func remove_item(item_name: String, amount: int = 1) -> bool:
	if not items.has(item_name) or items[item_name] < amount:
		return false
	items[item_name] -= amount
	if items[item_name] <= 0:
		items.erase(item_name)
	inventory_changed.emit()
	return true

func has_item(item_name: String, amount: int = 1) -> bool:
	return items.has(item_name) and items[item_name] >= amount

func get_quantity(item_name: String) -> int:
	return items.get(item_name, 0)

func get_all_items() -> Dictionary:
	return items.duplicate()
