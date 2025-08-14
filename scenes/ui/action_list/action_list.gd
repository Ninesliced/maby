extends Control
class_name ActionListUI

var player: Player

var action_ui_scene: PackedScene = preload("res://scenes/ui/action_list/action_ui.tscn")
var action_manager: ActionManager

var action_ui_list: Array[ActionUI] = []

func _ready():
	if !GameGlobal.player:
		await GameGlobal.on_player_added
	player = GameGlobal.player
	print("Player is ready, setting up action list UI")
	action_manager = player.action_manager
	set_ui(action_manager.get_actions())
	update_ui()
	action_manager.action_appended.connect(_append_action_ui)
	action_manager.action_popped_front.connect(_pop_action_ui)

func set_ui(actions: Array[Action]) -> void:
	for ui in action_ui_list:
		ui.queue_free()
	action_ui_list.clear()
	for i in range(actions.size()):
		var action_ui: ActionUI = _create_action_ui(actions[i])
		action_ui.position = Vector2(i * 18, 0)


func _pop_action_ui(action: Action) -> void:
	var action_ui: ActionUI = action_ui_list.pop_front()
	var tween = get_tree().create_tween()

	tween.tween_property(action_ui, "scale", Vector2.ZERO, 0.2)
	await tween.finished
		

	await update_ui()
	action_ui.queue_free()

func _append_action_ui(action: Action) -> void:
	var action_ui: ActionUI = _create_action_ui(action)
	action_ui.position = Vector2(action_ui_list.size() * 18, 0)
	update_ui()


func _create_action_ui(action: Action) -> ActionUI:
	var action_ui: ActionUI = action_ui_scene.instantiate()
	add_child(action_ui)
	action_ui_list.append(action_ui)
	action_ui.set_texture(action.texture)
	return action_ui

func update_ui():
	if action_ui_list.size() == 0:
		return
	await _reposition_action_ui()

	# if action_ui_list.size() > 0:
	# 	var first_ui: ActionUI = action_ui_list[0]
	# 	first_ui.scale = Vector2(1.2, 1.2)
	# 	for i in range(1, action_ui_list.size()):
	# 		var ui: ActionUI = action_ui_list[i]
	# 		ui.scale = Vector2(1, 1)

func _reposition_action_ui():
	var tween
	for i in range(action_ui_list.size()):
		var ui: ActionUI = action_ui_list[i]
		tween = get_tree().create_tween()
		tween.tween_property(ui, "position", _get_position(i), 0.2).set_ease(Tween.EASE_IN_OUT)
	await tween.finished

func _get_position(i: int) -> Vector2:
		return Vector2(i * 18, 0)
