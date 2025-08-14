extends Action

@export var target_tile_scene: PackedScene

func execute_action(tile: Tile) -> bool:
	if is_player_in_zone(tile):
		return false
	var map = GameGlobal.map
	assert(map != null, "Map is not initialized")

	var action_zone = get_action_zone()
	for pos in action_zone:
		var i = pos.x
		var j = pos.y
		var current_tile: Tile = map.get_tile_at(tile.grid_position + Vector2i(i, j))
		if current_tile == null:
			continue
		var new_tile: Tile = current_tile.transform_to_another_type(target_tile_scene, false)
		if !new_tile or new_tile.tile_bigger == null:
			continue
		new_tile.tile_bigger.play_full((i+1) * 0.1 + (j+1) * 0.1)
	return true

func get_action_zone() -> Array[Vector2i]:
	var list : Array[Vector2i] = []
	for i in range(-1, 2):
		for j in range(-1, 2):
			list.append(Vector2i(i, j))
	return list
