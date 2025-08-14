#import the map from thne original game - guigui

@tool
extends Node2D
class_name Map

@export var tiles: Array[TileGenerationData] = []
@export var grid_size: Vector2 = Vector2(10, 10)

func _ready() -> void:
	generate_grid()

func generate_grid() -> void:
	for x in range(grid_size.x):
		for y in range(grid_size.y):
			var tile: Tile = tiles[0].tile_scene.instantiate() # FIXME
			tile.position = Vector2(x, y) * 32 # FIXME constant
			add_child(tile)
