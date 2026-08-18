extends Node

## Simple Hunger & Thirst system for Olomu Survival vertical slice
## Attach this to the Player or an Autoload

signal hunger_changed(value: float)
signal thirst_changed(value: float)
signal player_died

@export var max_hunger: float = 100.0
@export var max_thirst: float = 100.0
@export var hunger_drain_rate: float = 0.8   # per second
@export var thirst_drain_rate: float = 1.2   # per second

var hunger: float = 100.0
var thirst: float = 100.0
var is_alive: bool = true

func _process(delta: float) -> void:
	if not is_alive:
		return

	hunger = max(hunger - hunger_drain_rate * delta, 0.0)
	thirst = max(thirst - thirst_drain_rate * delta, 0.0)

	hunger_changed.emit(hunger)
	thirst_changed.emit(thirst)

	if hunger <= 0.0 or thirst <= 0.0:
		_die()

func eat(amount: float) -> void:
	hunger = min(hunger + amount, max_hunger)
	hunger_changed.emit(hunger)

func drink(amount: float) -> void:
	thirst = min(thirst + amount, max_thirst)
	thirst_changed.emit(thirst)

func _die() -> void:
	is_alive = false
	player_died.emit()
	print("Player collapsed from hunger or thirst.")
