extends Tile

func can_pass(direction: Enums.Direction) -> bool:
	var dir_rotation: Enums.Direction = tile_rotation

	return direction != dir_rotation
	
	if direction == Enums.Direction.UP: # T shape
		return dir_rotation != Enums.Direction.UP # can't go up because wall
	elif direction == Enums.Direction.RIGHT:
		return dir_rotation != Enums.Direction.RIGHT
	elif direction == Enums.Direction.DOWN:
		return dir_rotation != Enums.Direction.DOWN
	elif direction == Enums.Direction.LEFT:
		return dir_rotation != Enums.Direction.LEFT
	
	return true
