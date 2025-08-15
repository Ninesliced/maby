extends Node2D
class_name ActionCurrentComponent

var action_ui: ActionUI = null


func _ready() -> void:
	var parent_node = get_parent()
	if parent_node is ActionUI:
		action_ui = parent_node
	else:
		assert(false, "ActionCurrentComponent must be a child of ActionUI node.")
	SignalBus.on_new_current_action.connect(set_current_action)

func _process(_delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	action_ui.global_position = mouse_position

func set_current_action(new_action: Action) -> void:
	var texture = new_action.texture
	action_ui.set_texture(texture)
