@tool
extends CanvasGroup

class_name Map

@export var tiles : Array[PackedScene] = []
@export var tiles_degree_of_freedom : Array[PackedScene] = []

@export var grid_size : Vector2i = Vector2i(5, 25):
	set(value):
		grid_size = value
		# _update_grid()
	

@export var tile_size : Vector2i = Vector2i(32, 32)

var grid : Array[Array] = []

func _ready() -> void:
	GameGlobal.map = self
	_update_grid()
	generate_grid()

# PUBLIC METHODS

func get_tile_at(grid_pos: Vector2i) -> Tile:
	return grid[grid_pos.x % grid_size.x][grid_pos.y % grid_size.y]

func set_tile_at(grid_pos: Vector2i, tile: Tile) -> void:
	grid[grid_pos.x % grid_size.x][grid_pos.y % grid_size.y] = tile
	tile.grid_position = Vector2i(grid_pos.x % grid_size.x, grid_pos.y % grid_size.y)

##PRIVATE

func _update_grid() -> void:
	for child in grid:
		for tile in child:
			if tile != null:
				tile.queue_free()
	grid.clear()
	
	for x in range(grid_size.x):
		var column = []
		for y in range(grid_size.y):
			column.append(null)
		grid.append(column)

func generate_grid() -> void:
	GameGlobal.rng.seed = hash(GameGlobal.rng_seed)
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			if grid[x][y] == null:
				var selected_tile: Resource = tiles[GameGlobal.rng.randi() % tiles.size()]
				var tile_scene = load(selected_tile.resource_path)
				var tile = tile_scene.instantiate()
				tile.tile_rotation = GameGlobal.rng.randi() % 4
				tile.position = Vector2i(x, y) * tile_size
				tile.grid_position = (Vector2i(x, y))
				add_child(tile)
				grid[x][y] = tile

func clear_grid() -> void:
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			if grid[x][y] != null:
				grid[x][y].queue_free()
				grid[x][y] = null

func clear_action_holders() -> void:
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			if grid[x][y] != null:
				var children = grid[x][y].action_holder.get_children()
				for child in children:
					child.queue_free()

func generate_grid_from_numbers(list) -> void:
	print("Generate grid from numbers")
	grid_size = Vector2(len(list[0]),len(list))
	# print(grid)
	print(grid_size	)
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var tile_number = int(str(list[y][x])[0])
			var tile_rotation = int(str(list[y][x])[1]) if len(str(list[y][x]))>1 else 0
			var selected_tile: Resource = tiles_degree_of_freedom[tile_number]
			# print(selected_tile)
			var tile_scene = load(selected_tile.resource_path)
			var tile : Tile = tile_scene.instantiate()
			tile.is_action_spawnable = false
			tile.tile_rotation = tile_rotation
			tile.position = Vector2i(x, y) * tile_size
			tile.grid_position = (Vector2i(x, y))
			add_child(tile)
			grid[x][y] = tile

func swap_tiles(tile1_co : Vector2i,tile2_co : Vector2i,) -> void:
	var tile1 : Tile = get_tile_at(tile1_co)
	var tile2 : Tile = get_tile_at(tile2_co)
	set_tile_at(tile1_co, tile2)
	set_tile_at(tile2_co, tile1)
	
	var temp_pos: Vector2 = tile1.position

	var visual_pos: Vector2 = tile1.visual.global_position
	var visual2_pos: Vector2 = tile2.visual.global_position

	tile1.position = tile2.position
	tile2.position = temp_pos

	tile1.visual.global_position = visual_pos
	tile2.visual.global_position = visual2_pos

	var tween = get_tree().create_tween()
	var tween2 = get_tree().create_tween()
	tween.tween_property(tile1.visual, "position", Vector2(0, 0), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween2.tween_property(tile2.visual, "position", Vector2(0, 0), 0.25).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	tile1.tile_bigger.play_full()
	tile2.tile_bigger.play_full()
	Audio.swap_sound_effect.play()

func regenerate_grid() -> void:
	clear_grid()
	generate_grid()
