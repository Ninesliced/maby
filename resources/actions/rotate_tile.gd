extends Action

func execute_action(tile: Tile) -> bool:
    if (is_player_in_zone(tile)):
        return false

    tile.rotate_clock()
    return true
