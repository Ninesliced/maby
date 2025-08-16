extends Node2D
class_name ActionPickable

@export var actions : Array[ActionPickableData] = []
var action: Action = null
var deleting: bool = false

func _ready() -> void:
	if action:
		return
	
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_area_2d_body_entered(player: Node2D) -> void:
	if deleting:
		return
	if !(player is Player):
		return

	player = player as Player
	player.action_manager.append(action)    
	queue_free()

func choose_an_random_action() -> void:
	var random_value: float = randf_range(0.0, _get_weight_probability())
	action = _get_action_by_probability(random_value)
	%Sprite2D.texture = action.texture

func _get_weight_probability() -> float:
	var total_probability: float = 0.0
	for action_data in actions:
		total_probability += action_data.probability
	return total_probability

func _get_action_by_probability(num: float) -> Action:
	var cumulative_probability: float = 0.0
	for action_data in actions:
		cumulative_probability += action_data.probability
		if cumulative_probability > num:
			return action_data.action
	return null
	
