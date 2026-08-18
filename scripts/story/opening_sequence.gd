extends Node

## Simple opening sequence controller for the vertical slice
## Attach to the main village scene

@export var father_dialogue: String = "Go. Don’t look back. Survive, and find your way home."

signal sequence_finished

var sequence_started: bool = false

func start_opening_sequence() -> void:
	if sequence_started:
		return
	sequence_started = true

	print("=== OLOMU OPENING SEQUENCE ===")
	print("The village is peaceful...")
	await get_tree().create_timer(2.0).timeout

	print("Suddenly there is confusion. People are running. Sounds of fighting in the distance.")
	await get_tree().create_timer(3.0).timeout

	print("Your father finds you.")
	await get_tree().create_timer(1.5).timeout

	print("Father: \"", father_dialogue, "\"")
	await get_tree().create_timer(4.0).timeout

	print("You must escape into the wilderness.")
	sequence_finished.emit()
	print("=== SEQUENCE COMPLETE ===")
