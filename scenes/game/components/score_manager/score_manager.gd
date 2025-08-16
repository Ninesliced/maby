extends Node
class_name ScoreManager

@export var tile_score: int = 10

var movement: int  = 0

var score: int = 0:
	set(value):
		if value != score:
			score = value
			if SignalBus:
				SignalBus.on_score_changed.emit(score)

func _ready() -> void:
	GameGlobal.score_manager = self
	if !GameGlobal.player:
		await GameGlobal.on_player_added

	SignalBus.on_player_move.connect(_on_player_move)

func _on_player_move(_player: Player, direction: Enums.Direction) -> void:
	if direction == Enums.Direction.LEFT:
		movement -= tile_score
	elif direction == Enums.Direction.RIGHT:
		movement += tile_score
	else:
		return
	
	score = max(score, movement)
