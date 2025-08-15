extends Node2D
class_name OutlineComponent
@onready var outline: Sprite2D = %Outline

static var outlined_tiles: Array[Tile] = []
var tile_parent: Tile
var outline_tween: Tween



func _ready() -> void:
	var parent = get_parent()
	assert(parent is Tile, "OutlineComponent must be a child of a Tile node.")
	tile_parent = parent as Tile
	SignalBus.on_tile_hovered.connect(_on_tile_hovered)
	SignalBus.on_player_move.connect(_on_player_move)
	SignalBus.tile_clicked.connect(_on_tile_clicked)

func _on_tile_hovered(_tile: Tile) -> void:
	_update_outline(_tile)

func _on_player_move(_player: Player, _direction: Enums.Direction) -> void:
	if !is_instance_valid(GameGlobal.hovered_tile):
		return
	_update_outline(GameGlobal.hovered_tile)
 
func _on_tile_clicked(_tile: Tile) -> void:
	if !is_instance_valid(GameGlobal.hovered_tile):
		return
	_update_outline(GameGlobal.hovered_tile)

# update on action changed and tile hovered or player moved
func _update_outline(tile: Tile) -> void:
	if tile == null:
		clear_outlines()
		return
	if tile != self.tile_parent:
		return
	spawn_outline()

func spawn_outline() -> void:
	clear_outlines()

	var action: Action = GameGlobal.player.action_manager.get_front()
	var is_action_valid = action.is_valid(tile_parent)

	var tiles = action.get_tiles_in_action_zone(tile_parent)
	if not tiles:
		return
	for tile in tiles:
		print("spawning outline for tile: ", tile.grid_position)
		if is_action_valid:
			tile.outline_component.outline.modulate = Color(1, 1, 1, 0.5)
		else:
			tile.outline_component.outline.modulate = Color(1, 50./255., 50./255., 1)
		tile.outline_component.show_outline()
		outlined_tiles.append(tile)

func _exit_tree() -> void:
	if !tile_parent:
		return
	outlined_tiles.erase(tile_parent)

# INTERNAL METHODS

func clear_outlines() -> void:
	for tile in outlined_tiles:
		if !tile:
			continue
		tile.outline_component.hide_outline()
	outlined_tiles.clear()

func show_outline() -> void:
	outline.visible = true
	low_visibility_outline()
	

func hide_outline() -> void:
	outline.visible = false
	if outline_tween:
		outline_tween.stop()


func low_visibility_outline() -> void:
	if not outline.visible:
		return
	
	var color := outline.modulate
	outline_tween = create_tween()
	outline_tween.tween_property(outline, "modulate", Color(color.r, color.g, color.b, 0.5), 0.6)
	outline_tween.set_ease(Tween.EASE_IN_OUT)
	outline_tween.tween_callback(high_visibility_outline)


func high_visibility_outline() -> void:
	if not outline.visible:
		return
	
	var color := outline.modulate
	outline_tween = create_tween()
	outline_tween.tween_property(outline, "modulate", Color(color.r, color.g, color.b, 0.9), 0.6)
	outline_tween.set_ease(Tween.EASE_IN_OUT)
	outline_tween.tween_callback(low_visibility_outline)
