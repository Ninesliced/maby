extends Action
class_name MultipleTypeAction

@export var target_tile_scene: PackedScene
@export_enum("Square", "Cross") var action_zone_type: String = "Square"

func execute_action(tile: Tile) -> bool:
	if super(tile) == false:
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
	Audio.explosion_sound_effect.play()
	return true

func get_action_zone() -> Array[Vector2i]:
	match action_zone_type:
		"Square":
			return get_action_zone_square()
		"Cross":
			return get_action_zone_cross()
		_:
			return get_action_zone_square()

func get_action_zone_square() -> Array[Vector2i]:
	var list : Array[Vector2i] = []
	for i in range(-1, 2):
		for j in range(-1, 2):
			list.append(Vector2i(i, j))
	return list

func get_action_zone_cross() -> Array[Vector2i]:
	var list: Array[Vector2i] = []
	for i in range(-1, 2):
		for j in range(-1, 2):
			list.append(Vector2i(i, j))

	# exclude border tiles
	list.erase(Vector2i(-1, -1))
	list.erase(Vector2i(-1, 1))
	list.erase(Vector2i(1, -1))
	list.erase(Vector2i(1, 1))

	return list
