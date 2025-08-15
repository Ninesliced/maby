extends State

@export var movement_component: MovementComponent

func _on_enter_state() -> void:
    movement_component.enabled = false
    SignalBus.on_player_died.emit()

func _on_exit_state() -> void:
    movement_component.enabled = true
