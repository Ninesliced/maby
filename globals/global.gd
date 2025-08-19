extends Node

var characters : Array[PlayerData] = [
    preload("res://resources/player/player_default.tres"),
    preload("res://resources/player/player2.tres"),
    preload("res://resources/player/player2.tres")

]

var main_menu_scene: PackedScene = preload("res://scenes/ui/main_menu/main_menu.tscn")

func go_to_main_menu() -> void:
    TransitionManager.change_scene(main_menu_scene, "circle_gradient", null, 1.0)
