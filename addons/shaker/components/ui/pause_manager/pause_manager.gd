extends Node

@export_file("*.tscn") var pause_menu
@export var pause_action: String = "pause"
var pause_menu_node: Node

var paused := false

func _ready() -> void:
	assert(pause_menu, "No menu defined")
	pause_menu_node = load(pause_menu).instantiate()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(pause_action):
		_toggle_pause()

func _pause():
	paused = true
	UIManager.set_ui(pause_menu_node)

func _unpause():
	paused = false
	UIManager.close_ui()

func _toggle_pause():
	if paused:
		_unpause()
	else:
		_pause()
