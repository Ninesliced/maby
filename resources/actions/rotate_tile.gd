extends Action

func execute_action(tile: Tile) -> bool:
    if super(tile) == false:
        print("false super")
        return false

    tile.rotate_clock()
    return true
