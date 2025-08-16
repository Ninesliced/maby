extends State

@export var movement_component: MovementComponent

func _on_enter_state() -> void:
	movement_component.enabled = false
	SignalBus.on_player_died.emit()
	if GameGlobal.is_seed_of_the_day:
		GameGlobal.request.submit(GameGlobal.username, GameGlobal.score_manager.score)
	

func _on_exit_state() -> void:
	movement_component.enabled = true
