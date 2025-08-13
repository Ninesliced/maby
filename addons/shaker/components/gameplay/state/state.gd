# ABSTRACT CLASS
extends AbstractState
class_name State

var state_machine: StateMachine

func _ready() -> void:
	assert(get_parent() is StateMachine)
	state_machine = get_parent()
	
	enter_state.connect(_on_enter_state)
	exit_state.connect(_on_exit_state)

func _on_enter_state():
	pass

func _on_exit_state():
	pass
