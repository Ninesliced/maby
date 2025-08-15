extends Node
class_name ScoreManager

@export var tile_score: int = 10
@export var loop_score: int = 500

var score: int = 0:
    set(value):
        if value != score:
            score = value
            if SignalBus:
                SignalBus.on_score_changed.emit(score)

var player_max_x: int = -1

func _ready() -> void:
    GameGlobal.score_manager = self
    if !GameGlobal.player:
        await GameGlobal.on_player_added

    var player = GameGlobal.player
    var grid_position = player.movement_component.grid_position
    player_max_x = grid_position.x
    SignalBus.on_player_move.connect(_on_player_move)

func _on_player_move(player: Player, direction: Enums.Direction) -> void:
    var player_grid_position = player.movement_component.grid_position
    var delta = player_grid_position.x - player_max_x

    if delta > 0:
        score += delta * tile_score
        player_max_x = player_grid_position.x
        return

    if delta < - GameGlobal.map.grid_size.x + 1:
        score += loop_score
    pass