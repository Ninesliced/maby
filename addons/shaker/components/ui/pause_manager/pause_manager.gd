extends Node

@export_file("*.tscn") var pause_menu
@export var pause_action: String = "pause"
var pause_menu_node: Node

var paused := false

func _ready() -> void:
	assert(pause_menu, "No menu defined")
	# pause_menu_node = load(pause_menu).instantiate()
