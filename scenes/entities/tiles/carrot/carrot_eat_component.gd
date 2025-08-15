extends Node

var tile: Tile

@export var area: Area2D
@export var sprite: AnimatedSprite2D
@export var tile_bigger: AnimationPlayer

func _ready():
    tile = get_parent()
    assert(tile is Tile, "CursedComponent: Parent is not a Tile")
    area.body_entered.connect(_on_entered)

func _on_entered(body: Node) -> void:
    if not (body is Player):
        return
    sprite.play("no_carrot")
    tile_bigger.play("full")
    pass
    
