extends AbstractState
class_name StateMachine

@export var default_state: AbstractState

var _states = []
var current_state_name: String
var current_state: AbstractState = null

func _ready() -> void:
	var children = get_children()
	_states = children.filter(func(child): return child is AbstractState)
	
	for state in _states:
		state.process_mode = Node.PROCESS_MODE_DISABLED
	
	if default_state:
		set_state(default_state.name)

func set_state(name: String):
	var node = get_node_or_null(name)
	assert(node, "Invalid state: '" + str(name) + "'")
	assert(node is AbstractState, "Node '" + str(name) + "' isn't an AbstractState")
	
	if current_state:
		current_state.process_mode = Node.PROCESS_MODE_DISABLED
		current_state.exit_state.emit()
		
	node.process_mode = Node.PROCESS_MODE_INHERIT
	node.enter_state.emit()
	
	current_state_name = name
	current_state = node
