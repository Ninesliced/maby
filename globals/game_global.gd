extends Node

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var rng_seed: Variant = 1232
var map: Map
var player: Player:
    set(value):
        player = value
        if player:
            on_player_added.emit(value)
var game: Game
var camera: Camera2D

signal on_player_added(player: Player)

func _ready() -> void:
    print("ready")
    rng.randi()