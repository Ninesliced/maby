extends Resource
class_name Action

@export_group("General")
@export var name: String
@export var texture: Texture2D

@export_group("Properties")
@export var temporary: bool = false

func execute_action(tile) -> bool:
	return is_valid(tile)

func get_action_zone() -> Array[Vector2i]:
	return [Vector2i(0, 0)]

func get_tiles_in_action_zone(selected_tile: Tile):
	var map: Map = GameGlobal.map
	var tiles: Array[Tile] = []
	if not map:
		push_error("Map is not initialized.")
		return null

	var zones: Array[Vector2i] = get_action_zone()
	for pos in zones:
		var grid_pos = (selected_tile.grid_position + pos) % GameGlobal.map.grid_size
		if grid_pos.x < 0:
			grid_pos.x += GameGlobal.map.grid_size.x
		if grid_pos.y < 0:
			grid_pos.y += GameGlobal.map.grid_size.y

		var tile: Tile = GameGlobal.map.grid[grid_pos.x][grid_pos.y]
		if tile and tile.outline:
			tiles.append(tile)
		
	return tiles

func is_valid(tile) -> bool:
	return !is_player_in_zone(tile)

func is_player_in_zone(tile: Tile) -> bool:
	var player: Player = GameGlobal.player
	if not player or not player.movement_component:
		push_error("Player or movement component is not initialized.")
		return true
	var map: Map = GameGlobal.map
	if not map:
		push_error("Map is not initialized.")
		return true

	var zones: Array[Vector2i] = get_action_zone()

	for pos in zones:
		var target_pos = (tile.grid_position + pos) % map.grid_size
		if target_pos.x < 0:
			target_pos.x += map.grid_size.x
		if target_pos.y < 0:
			target_pos.y += map.grid_size.y
		
		if target_pos == player.movement_component.grid_position:
			return true
	return false
