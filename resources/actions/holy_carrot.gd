extends Action
class_name HolyCarrotAction

@export var target_tile_scene: PackedScene

func execute_action(tile: Tile) -> bool:
	if super(tile) == false:
		return false

	for i in range(-1, 2):
		var row_pos := tile.grid_position + Vector2i(0, i)
		place_row(row_pos, 6)
	return true

func place_row(start_position: Vector2i, number: int) -> void:
	var map: Map = GameGlobal.map
	assert(map != null, "Map is not initialized")

	Audio.long_explosion_sound_effect.play()
	
	for i in range(number):
		var current_tile: Tile = map.get_tile_at(start_position + Vector2i(i, 0))
		if current_tile == null:
			continue
		var new_tile: Tile = current_tile.transform_to_another_type(target_tile_scene, false)
		new_tile.tile_bigger.play_full()
		await new_tile.get_tree().create_timer(0.1).timeout
		

func get_action_zone() -> Array[Vector2i]:
	var list: Array[Vector2i] = []
	for i in range(-1, 2):
		for j in range(6):
			list.append(Vector2i(j, i))
	return list
