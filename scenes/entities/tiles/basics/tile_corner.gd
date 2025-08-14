extends Tile

func can_pass(direction: Enums.Direction) -> bool:
    var d: int = int(direction)
    var r: int = int(tile_rotation)
    return r == (d + 1) % 4 or r == (d + 2) % 4