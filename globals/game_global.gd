extends Node

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var rng_seed: Variant = 1232
var is_seed_of_the_day: bool = false
var is_user_seed: bool = false
var username: String = ""

var map: Map
var player: Player:
	set(value):
		player = value
		if player:
			on_player_added.emit(value)
var game: Game
var camera: Camera2D
var hovered_tile: Tile: 
	set(value):
		hovered_tile = value
		SignalBus.on_tile_hovered.emit(value)
var score_manager: ScoreManager
var request: Request
		

signal on_player_added(player: Player)

func _ready() -> void:
	print("ready")
	rng.randi()

func reset() -> void:
	map = null
	player = null
	game = null
	camera = null
	hovered_tile = null
	score_manager = null
