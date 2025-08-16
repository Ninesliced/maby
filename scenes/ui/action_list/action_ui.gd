extends Control
class_name ActionUI
@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var texture_rect: TextureRect = %TextureRect

func set_texture(texture: Texture2D) -> void:
	texture_rect.texture = texture

func play_add() -> void:
	animation_player.play("pop")
