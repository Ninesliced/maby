extends Node

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var rng_seed: Variant = 1232
var map: Map

func _ready() -> void:
    print("ready")
    rng.randi()