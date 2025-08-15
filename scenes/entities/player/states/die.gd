extends State

@export var movement_component: MovementComponent

func _on_enter_state() -> void:
    movement_component.enabled = false
    get_tree().reload_current_scene()

func _on_exit_state() -> void:
    movement_component.enabled = true
