extends Node

enum Direction {
    UP = 0,
    RIGHT = 1,
    DOWN = 2,
    LEFT = 3
}

func direction_to_vector(direction: Direction) -> Vector2:
    match direction:
        Direction.UP: return Vector2(0, -1)
        Direction.RIGHT: return Vector2(1, 0)
        Direction.DOWN: return Vector2(0, 1)
        Direction.LEFT: return Vector2(-1, 0)
    return Vector2.ZERO