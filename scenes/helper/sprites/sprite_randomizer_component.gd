extends Node
class_name SpriteRandomizerComponent

var animated_sprite: AnimatedSprite2D
@export var prefix: String = ""

func _ready() -> void:
	var parent_node = get_parent()
	assert(parent_node is AnimatedSprite2D, "Parent node must be an AnimatedSprite2D")
	animated_sprite = parent_node as AnimatedSprite2D

	var list : Array = animated_sprite.sprite_frames.get_animation_names() as Array
	assert(list.size() != 0, "AnimatedSprite2D must have at least one animation defined.")

	var filtered_list: Array = list.filter(func(anim_name: String) -> bool: return anim_name.begins_with(prefix))
	var random_animation = filtered_list[randi() % filtered_list.size()]
	animated_sprite.play(random_animation)
