extends Action
class_name SwapTilesAction

@export_enum("Horizontal", "Vertical") var ORIENTATION: String = "Horizontal"

func execute_action(tile: Tile) -> bool:
	if super(tile) == false:
		return false
	var map: Map = GameGlobal.map
	assert(map != null, "Map is not initialized")
	
	var action_zone: Array[Vector2i] = get_action_zone()
	map.swap_tiles(tile.grid_position + action_zone[0], tile.grid_position + action_zone[1])

	return true

func get_action_zone() -> Array[Vector2i]:
	var list: Array[Vector2i] = []
	list.append(Vector2i(0, 0))
	if ORIENTATION == "Horizontal":
		list.append(Vector2i(1, 0))
	else:
		list.append(Vector2i(0, 1))
	return list
