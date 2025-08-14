extends Node2D
class_name Game

var has_game_started: bool = false

func _ready() -> void:
	GameGlobal.game = self
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass
