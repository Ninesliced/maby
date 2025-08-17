extends Node2D

var ACTION_SCENE: PackedScene = preload("res://scenes/entities/action_pickable/action_pickable.tscn")

func _ready():
	#init the game
	GameGlobal.map.clear_grid()

	GameGlobal.map.generate_grid_from_numbers([
		[0 ,0 ,0 ,0 ,0 ,21,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
		[0 ,0 ,0 ,0 ,0 ,21,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
		[0 ,0 ,2 ,2 ,2 ,11,0 ,13,2 ,2 ,21,2 ,2 ,5 ,5 ,5 ,2 ,1 ,0 ,13,3 ,2 ,21,21,21,21,2 ,2 ,21,0 ,2 ,2 ,2 ,2 ,0 ,0 ,2 ,2 ,6 ,0 ,0 ],
		[0 ,0 ,0 ,0 ,0 ,0 ,0 ,21,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,12,2 ,32,11,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,21,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
		[0 ,0 ,0 ,0 ,0 ,13,2 ,11,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ,0 ],
	])

	
	var action = ACTION_SCENE.instantiate()
	action.action = load("res://resources/actions/rotate_tile.tres")
	action.position = Vector2i(8,8)
	GameGlobal.map.grid[8][2].action_holder.add_child(action)

	action = ACTION_SCENE.instantiate()
	action.action = load("res://resources/actions/carrot.tres")
	action.position = Vector2i(8,8)
	GameGlobal.map.grid[32][2].action_holder.add_child(action)

	action = ACTION_SCENE.instantiate()
	action.action = load("res://resources/actions/vertical_swap.tres")
	action.position = Vector2i(8,8)
	GameGlobal.map.grid[27][2].action_holder.add_child(action)
	
	# GameGlobal.spawn_enemy_on_tile(GameGlobal.map.grid[19][2])
	var enemy : Wolf = preload("res://scenes/entities/enemies/wolf/wolf.tscn").instantiate()
	enemy.target = GameGlobal.player
	enemy.grid_position = Vector2i(19, 2)
	GameGlobal.map.get_parent().add_child(enemy)
