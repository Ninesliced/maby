extends Action

@export var target_tile_scene: PackedScene

func execute_action(tile: Tile) -> void:
	var map = GameGlobal.map
	assert(map != null, "Map is not initialized")

	for i in range(-1,2):
		for j in range(-1,2):
			var current_tile: Tile = map.grid[(tile.grid_position.x+i)%map.grid_size.x][(tile.grid_position.y+j)%map.grid_size.y]
			if current_tile == null:
				continue
			var new_tile: Tile = current_tile.transform_to_another_type(target_tile_scene, false)
			if !new_tile or new_tile.tile_bigger == null:
				continue
			new_tile.tile_bigger.play_full((i+1) * 0.1 + (j+1) * 0.1)
	pass
