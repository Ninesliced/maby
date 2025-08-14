extends Node
class_name MovementComponent

var parent : Player

var is_moving : bool = false
# var actual_score: int = 0:
# 	set(value):
# 		actual_score = value
# 		# GameGlobal.score = value

signal on_move(direction: Vector2)
signal on_idle()

var grid_position : Vector2i = Vector2i(0, 2) :
	set(value):
		if is_moving:
			return
		
		var map = GameGlobal.map
		if !map:
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


func _process(delta):
	var x_direction: float = Input.get_axis("left", "right")
	var y_direction: float = Input.get_axis("up", "down")
	if x_direction == 0 and y_direction == 0:
		if !is_moving:
			on_idle.emit()
		return
	
	if is_moving:
		return
	
	var move_direction: Vector2i = Vector2i.ZERO
	
	if x_direction > 0.4:
		move_direction = Vector2i(1, 0)
	elif x_direction < -0.4:
		move_direction = Vector2i(-1, 0)

	if y_direction > 0.4:
		move_direction = Vector2i(0, 1)
	elif y_direction < -0.4:
		move_direction = Vector2i(0, -1)
	move_player(move_direction)
	
var last_inside_direction: Enums.Direction

func move_player(move_direction: Vector2i) -> void:
	var map : Map = GameGlobal.map
	var next_pos = Vector2i(grid_position + move_direction) % map.grid_size
	
	var current_tile : Tile = GameGlobal.map.grid[grid_position.x][grid_position.y]
	var next_tile : Tile = GameGlobal.map.grid[next_pos.x][next_pos.y]
	
	var inside_direction : Enums.Direction
	var outside_direction : Enums.Direction
	if move_direction == Vector2i(1, 0):
		inside_direction = Enums.Direction.RIGHT
		outside_direction = Enums.Direction.LEFT
	elif move_direction == Vector2i(-1, 0):
		inside_direction = Enums.Direction.LEFT
		outside_direction = Enums.Direction.RIGHT
	elif move_direction == Vector2i(0, 1):
		inside_direction = Enums.Direction.DOWN
		outside_direction = Enums.Direction.UP
	elif move_direction == Vector2i(0, -1):
		inside_direction = Enums.Direction.UP
		outside_direction = Enums.Direction.DOWN
	else:
		return
	
	if current_tile == null or next_tile == null or not current_tile.can_pass(inside_direction) or not next_tile.can_pass(outside_direction):
		return
			
	last_inside_direction = inside_direction
	
	# GameGlobal.is_game_have_start = true

	on_move.emit(move_direction)
	grid_position += move_direction
	# GameGlobal.number_of_actions += 1
	
	# actual_score += move_direction.x * 10
	
	#FIXME shouldn't be here, make a script which connect to the signal on_move
	# walk_sound_effect.pitch_scale = randf_range(0.8, 1.3) 
	# walk_sound_effect.play()
	
	# Update outline
	# var hovered_tile = GameGlobal.hovered_tile
	# if hovered_tile:
	#     hovered_tile.on_action(GameGlobal.action_stacks[0])
	


func update_position():
	var map = GameGlobal.map

	var target_position = map.grid[grid_position.x][grid_position.y].global_position + Vector2(map.tile_size) / 2
	
	var distance = (parent.position - target_position).length()
	if get_tree() and distance < 64:
		translation_animation(target_position)
	else:
		parent.position = target_position
		is_moving = true
		var tween = create_tween()
		tween.tween_interval(0.2)
		tween.tween_callback(stop_movement)


func translation_animation(target_position: Vector2) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(parent, "position", target_position, 0.3)
	tween.tween_callback(stop_movement)
	tween.set_ease(Tween.EASE_IN_OUT)
	is_moving = true

func stop_movement() -> void:
	is_moving = false
