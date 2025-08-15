extends Node

## Emit a signal when a tile is clicked
signal tile_clicked(tile: Tile)
signal on_player_move(player: Player, direction: Enums.Direction)
signal on_player_event()
signal on_player_action(player: Player, action: Action)
signal on_player_skill()
signal on_player_idle(player: Player)
signal on_player_died()
signal on_new_current_action(action: Action)

# TILE

signal on_tile_hovered(tile: Tile)

signal on_score_changed(score: int)

func _ready() -> void:
	_init_player_event_signal()

func _init_player_event_signal() -> void:
	on_player_move.connect(func (_p, _d): on_player_event.emit())
	tile_clicked.connect(func (_t): on_player_event.emit())
	
