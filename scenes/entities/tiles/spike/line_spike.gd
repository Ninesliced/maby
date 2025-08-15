extends Spike

func can_pass(direction: Enums.Direction) -> bool:
	var dir_rotation: Enums.Direction = tile_rotation

	if direction == Enums.Direction.UP:
		return dir_rotation == Enums.Direction.LEFT or dir_rotation == Enums.Direction.RIGHT
	elif direction == Enums.Direction.RIGHT:
		return dir_rotation == Enums.Direction.UP or dir_rotation == Enums.Direction.DOWN
	elif direction == Enums.Direction.DOWN:
		return dir_rotation == Enums.Direction.LEFT or dir_rotation == Enums.Direction.RIGHT
	elif direction == Enums.Direction.LEFT:
		return dir_rotation == Enums.Direction.UP or dir_rotation == Enums.Direction.DOWN

	return true
