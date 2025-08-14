extends Node

## Emit a signal when a tile is clicked
signal tile_clicked(tile: Tile)
signal on_player_move(player: Player, direction: Enums.Direction)
signal on_player_idle(player: Player)