extends Node

## Emit a signal when a tile is clicked
signal tile_clicked(tile: Tile)
signal on_player_move(player: Player, direction: Enums.Direction)
signal on_player_event()

signal on_player_idle(player: Player)


func _ready() -> void:
    _init_player_event_signal()

func _init_player_event_signal() -> void:
    on_player_move.connect(func (_p, _d): on_player_event.emit())
    tile_clicked.connect(func (_t): on_player_event.emit())
    