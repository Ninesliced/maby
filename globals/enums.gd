extends Node

enum Direction {
	UP = 0,
	RIGHT = 1,
	DOWN = 2,
	LEFT = 3
}

func direction_to_vector(direction: Direction) -> Vector2i:
	match direction:
		Direction.UP: return Vector2i(0, -1)
		Direction.RIGHT: return Vector2i(1, 0)
		Direction.DOWN: return Vector2i(0, 1)
		Direction.LEFT: return Vector2i(-1, 0)
	return Vector2i.ZERO

func vector_to_direction(vec: Vector2i) -> Direction:
	match vec:
		Vector2i(0, -1): return Direction.UP
		Vector2i(1, 0): return Direction.RIGHT
		Vector2i(0, 1): return Direction.DOWN
		Vector2i(-1, 0): return Direction.LEFT
	assert(false, "Invalid vector for direction conversion: %s" % vec)
	return Direction.UP #avoid type error
