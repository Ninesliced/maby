extends Node
class_name SpriteRandomizerComponent

var animated_sprite: AnimatedSprite2D

func _ready() -> void:
	var parent_node = get_parent()
	assert(parent_node is AnimatedSprite2D, "Parent node must be an AnimatedSprite2D")
	animated_sprite = parent_node as AnimatedSprite2D

	var list = animated_sprite.sprite_frames.get_animation_names()
	assert(list.size() != 0, "AnimatedSprite2D must have at least one animation defined.")

	var random_animation = list[randi() % list.size()]
	animated_sprite.play(random_animation)
