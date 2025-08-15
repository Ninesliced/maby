extends Tile

func can_pass(direction: Enums.Direction) -> bool:
	return abs(int(direction) - int(tile_rotation)) % 2 == 1