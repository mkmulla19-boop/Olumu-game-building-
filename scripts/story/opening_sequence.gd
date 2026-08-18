extends Node

## Opening sequence - Father's final words
## Can be triggered automatically or manually for testing

@export var auto_start: bool = false
@export var auto_start_delay: float = 3.0
@export var father_line: String = "Go. Don’t look back. Survive, and find your way home."

signal sequence_started
signal sequence_finished
signal show_dialogue(text: String)

var has_played: bool = false
var is_playing: bool = false

func _ready() -> void:
	if auto_start:
		await get_tree().create_timer(auto_start_delay).timeout
		start_sequence()

func start_sequence() -> void:
	if has_played or is_playing:
		return

	is_playing = true
	has_played = true
	sequence_started.emit()

	print("=== OLOMU OPENING ===")
	_show("The village is peaceful this morning...")
	await get_tree().create_timer(2.5).timeout

	_show("Suddenly there is confusion. People are running.")
	await get_tree().create_timer(2.8).timeout

	_show("Sounds of fighting can be heard in the distance.")
	await get_tree().create_timer(2.5).timeout

	_show("Your father finds you.")
	await get_tree().create_timer(1.8).timeout

	_show("Father: \"" + father_line + "\"")
	await get_tree().create_timer(4.5).timeout

	_show("You must escape into the wilderness.")
	await get_tree().create_timer(2.0).timeout

	is_playing = false
	sequence_finished.emit()
	print("=== OPENING COMPLETE ===")

func _show(text: String) -> void:
	print(text)
	show_dialogue.emit(text)
