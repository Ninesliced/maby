extends Node
class_name MovementComponent

@export var duration_between_moves: float = 0.4

var enabled: bool = true
var parent : Player
var is_moving : bool = false

signal on_move(direction: Vector2)
signal on_idle()

@export var grid_position : Vector2i = Vector2i(2, 2):
	set(value):
		if is_moving:
			return
		
		var map = GameGlobal.map
		if !map:
			print()
			return
		grid_position.x = value.x % map.grid_size.x
		grid_position.y = value.y % map.grid_size.y
		
		if grid_position.x < 0:
			grid_position.x = map.grid_size.x - 1
		if grid_position.y < 0:
			grid_position.y = map.grid_size.y - 1
		update_position()

func _ready():
	if parent == null:
		var new_parent = get_parent()
		if new_parent is Player:
			parent = new_parent
		else:
			assert(false, "MovementComponent must be a child of a CharacterBody2D node.")
	update_position()


func _process(_delta):
	if not enabled:
		return
	if is_moving:
		return
	
	var move_direction = _get_input_direction()
	if move_direction == Vector2i.ZERO:
		return
	move_player(move_direction)
	
var last_inside_direction: Enums.Direction

func move_player(move_direction: Vector2i) -> void:
	var map : Map = GameGlobal.map
	var next_pos = Vector2i(grid_position + move_direction) % map.grid_size
	
	var current_tile : Tile = GameGlobal.map.grid[grid_position.x][grid_position.y]
	var next_tile : Tile = GameGlobal.map.grid[next_pos.x][next_pos.y]
	
	var inside_direction : Enums.Direction = Enums.vector_to_direction(move_direction)
	var outside_direction : Enums.Direction = (inside_direction + 2) % 4
	
	if current_tile == null or next_tile == null or not current_tile.can_pass(inside_direction) or not next_tile.can_pass(outside_direction):
		return
			
	last_inside_direction = inside_direction # used to prevent player to go back to the previous tile

	on_move.emit(move_direction)
	grid_position += move_direction
	SignalBus.on_player_move.emit(parent, inside_direction)


func update_position():
	if !parent:
		return
	var map = GameGlobal.map
	var target_position = map.grid[grid_position.x][grid_position.y].global_position + Vector2(map.tile_size) / 2

	var is_tile_near = (parent.position - target_position).length() < map.tile_size.y * 2
	print(grid_position)
	if get_tree() and is_tile_near:
		translation_animation(target_position)
	else:
		parent.position = target_position
		is_moving = true
		var tween = create_tween()
		tween.tween_interval(duration_between_moves / 2)
		tween.tween_callback(_stop_movement)


func translation_animation(target_position: Vector2) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(parent, "position", target_position, duration_between_moves)
	tween.tween_callback(_stop_movement)
	tween.set_ease(Tween.EASE_IN_OUT)
	tween.set_trans(Tween.TRANS_EXPO)
	is_moving = true

func _stop_movement() -> void:
	on_idle.emit()
	SignalBus.on_player_idle.emit()
	is_moving = false



func _get_input_direction() -> Vector2i:
	var x_direction: float = Input.get_axis("left", "right")
	var y_direction: float = Input.get_axis("up", "down")
	var move_direction: Vector2i = Vector2i.ZERO
	
	if x_direction > 0.4:
		move_direction = Vector2i(1, 0)
	elif x_direction < -0.4:
		move_direction = Vector2i(-1, 0)
	if y_direction > 0.4:
		move_direction = Vector2i(0, 1)
	elif y_direction < -0.4:
		move_direction = Vector2i(0, -1)

	return move_direction
