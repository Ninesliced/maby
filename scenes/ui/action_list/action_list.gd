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
	action_manager = player.action_manager
	set_ui(action_manager.get_actions())
	update_ui()
	action_manager.action_appended.connect(_append_action_ui)
	action_manager.action_popped_at.connect(_pop_action_ui_at)

func set_ui(actions: Array[Action]) -> void:
	for ui in action_ui_list:
		ui.queue_free()
	action_ui_list.clear()
	for i in range(actions.size()):
		var action_ui: ActionUI = _create_action_ui(actions[i], i)
		action_ui.position = Vector2(i * 18, 0)


func _pop_action_ui_at(number: int) -> void:
	if !is_inside_tree(): #hack
		return
	var action_ui: ActionUI = action_ui_list.pop_at(number)
	var tween = get_tree().create_tween()

	tween.tween_property(action_ui, "scale", Vector2.ZERO, 0.2)
	await tween.finished
		

	await update_ui()
	action_ui.queue_free()

func _append_action_ui(action: Action, index: int) -> void:
	var action_ui: ActionUI = _create_action_ui(action, index)
	action_ui.position = Vector2(index * 18, 0)
	update_ui()

func _create_action_ui(action: Action, index: int):
	var action_ui: ActionUI = action_ui_scene.instantiate()
	add_child(action_ui)
	action_ui_list.insert(index, action_ui)
	action_ui.set_texture(action.texture)
	action_ui.play_add()
	return action_ui

func update_ui():
	if action_ui_list.size() == 0:
		return
	await _reposition_action_ui()

func _reposition_action_ui():
	var tween
	for i in range(action_ui_list.size()):
		var ui: ActionUI = action_ui_list[i]
		tween = get_tree().create_tween()
		var property = tween.tween_property(ui, "position", _get_position(i), 0.4)
		property.set_ease(Tween.EASE_OUT)
		property.set_trans(Tween.TRANS_QUINT)
	await tween.finished

func _get_position(i: int) -> Vector2:
		return Vector2(i * 18, 0)
