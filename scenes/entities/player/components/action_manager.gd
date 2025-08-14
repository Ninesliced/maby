extends Node
class_name ActionManager

@export var enabled: bool = true

var player_data: PlayerData

var _actions: Array[Action] = []

signal action_popped_front(action: Action)
signal action_appended(action: Action)
signal action_set(actions: Array[Action])

func _ready():
	if !enabled:
		set_process(false)
		return
	var player: Player = get_parent()
	if not player:
		assert(false, "ActionManager must be a child of Player.")
	if !player.player_data:
		assert(false, "Player has no PlayerData assigned.")
	player_data = player.player_data
	_actions = player_data.actions
	action_set.emit(_actions)
	SignalBus.tile_clicked.connect(_execute_action)

func _execute_action(tile):
	if not enabled:
		return

	var result = false
	var action : Action = get_front()

	if action:
		result = action.execute_action(tile)

	if !result:
		return

	pop_front()

	if !action.temporary:
		append(action)


# PUBLIC METHODS

func get_front() -> Action:
	if _actions.size() == 0:
		return null
	return _actions[0]

## Returns the first action in the queue
func pop_front() -> Action:
	if _actions.size() == 0:
		return null
	action_popped_front.emit(_actions[0])
	return _actions.pop_front()

## Appends the action to the end of the queue
func append(action: Action):
	_actions.append(action)
	action_appended.emit(action)

## Get actions, don't modify the returned array
func get_actions() -> Array[Action]:
	return _actions
