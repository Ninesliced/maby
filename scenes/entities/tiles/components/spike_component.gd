extends Node

var parent : Tile
@onready var collision_shape_2d: CollisionShape2D = %SpikeCollision
@onready var sprite := %Sprite

func _ready() -> void:
	print("SpikeComponent: _ready")
	collision_shape_2d.disabled = true
	var tile := get_parent()
	if not (tile is Tile):
		print("CursedComponent: Parent is not a Tile")
		return
	parent = tile
	sprite.play("spike_in")
	call_deferred("connect_signals")

func connect_signals() -> void:
	SignalBus.on_player_action.connect(on_action_performed)


func on_action_performed(player : Player, action: Action):
	if collision_shape_2d.disabled:
		collision_shape_2d.disabled = false
		sprite.play("spike_out")
	else:
		collision_shape_2d.disabled = true
		sprite.play("spike_in")
