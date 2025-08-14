extends State
class_name NormalState

@export var movement_component: MovementComponent

func _on_enter_state() -> void:
	movement_component.enabled = true
	pass

func _on_exit_state() -> void:
	movement_component.enabled = false
	pass
