extends Node2D
class_name Game

var has_game_started: bool = false

func _ready() -> void:
	GameGlobal.game = self
	GameGlobal.hovered_tile = null
	SignalBus.on_player_event.connect(start_game)

func start_game() -> void:
	has_game_started = true

func _exit_tree() -> void:
	GameGlobal.reset()