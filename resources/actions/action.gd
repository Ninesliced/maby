extends Resource
class_name Action

@export_group("General")
@export var name: String
@export var texture: Texture2D

@export_group("Properties")
@export var temporary: bool = false

func execute_action(tile):
    pass
