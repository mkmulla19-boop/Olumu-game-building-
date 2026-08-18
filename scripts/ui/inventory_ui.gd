extends Control

## Simple inventory display for the vertical slice
## Shows current items the player is carrying

@onready var item_list: ItemList = $Panel/ItemList
@onready var close_btn: Button = $Panel/CloseButton

var inventory: Node = null
var is_open: bool = false

func _ready() -> void:
	hide()
	if close_btn:
		close_btn.pressed.connect(close)

func setup(inv: Node) -> void:
	inventory = inv
	if inventory and inventory.has_signal("inventory_changed"):
		inventory.inventory_changed.connect(refresh)

func toggle() -> void:
	if is_open:
		close()
	else:
		open()

func open() -> void:
	is_open = true
	show()
	refresh()

func close() -> void:
	is_open = false
	hide()

func refresh() -> void:
	if not item_list or not inventory:
		return

	item_list.clear()
	var items: Dictionary = inventory.get_all_items()

	if items.is_empty():
		item_list.add_item("Empty")
		return

	for item_name in items.keys():
		var qty: int = items[item_name]
		item_list.add_item(str(item_name) + "  x" + str(qty))
