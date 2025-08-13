extends Control
class_name ActionUI

@onready var texture_rect: TextureRect = %TextureRect

func set_texture(texture: Texture2D) -> void:
	texture_rect.texture = texture
