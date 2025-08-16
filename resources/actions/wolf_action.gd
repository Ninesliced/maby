extends Action
class_name WolfAction
const ENEMY = preload("res://scenes/entities/enemies/wolf/wolf.tscn")

func execute_action(tile: Tile) -> bool:
	if super(tile) == false:
		return false
	var map = GameGlobal.map
	assert(map != null, "Map is not initialized")

	var tiles = get_tiles_in_action_zone(tile)

	for t in tiles:
		var new_tile = t.transform_to_another_type(load("res://scenes/entities/tiles/basics/tile_four.tscn")) # FIXME try preload

	_spawn_enemy_on_tile(tile)
	return true

func _spawn_enemy_on_tile(tile: Tile) -> void:
	var enemy : Wolf = ENEMY.instantiate()
	var player: Player = GameGlobal.player
	if not player:
		assert(false, "Player is not initialized for wolf action")
	enemy.target = player
	player.get_parent().add_child(enemy)
	enemy.grid_position = tile.grid_position
	Audio.wolf_spawn_sound_effect.play()
	Audio.explosion_sound_effect.play()

func get_action_zone() -> Array[Vector2i]:
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
