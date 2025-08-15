extends Node

var enabled: bool = false

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("restart"):
        get_tree().reload_current_scene()
    if event.is_action_pressed("debug"):
        enabled = !enabled
