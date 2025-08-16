extends Node
class_name ActionManager

@export var enabled: bool = true
@export var max_actions: int = 6

var player_data: PlayerData

var _actions: Array[Action] = []

signal action_popped(action: Action)
signal action_popped_at(number: int)
signal action_appended(action: Action, index: int)
signal action_set(actions: Array[Action])

var current_action: Action = null:
	set(value):
		if value != current_action:
			current_action = value
			SignalBus.on_new_current_action.emit(value)

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
	if _actions.size() > 0:
		current_action = _actions[0]
	


# PUBLIC METHODS

func get_front() -> Action:
	if _actions.size() == 0:
		return null
	return _actions[0]

## Returns the first action in the queue
func pop_next() -> Action:
	if _actions.size() == 0:
		return null
	var action: Action = _try_pop_next(0)
	if not action:
		return null
	action_popped.emit(action)

	_set_current_action()
	return action

func add_front(action: Action, override: bool = true) -> void:
	if override and _actions.size() >= max_actions:
		_try_pop_next(0)
	_actions.insert(0, action)
	action_appended.emit(action, 0)

	_set_current_action()

## Appends the action to the end of the queue
func append(action: Action):
	if _actions.size() >= max_actions:
		_try_pop_next(0)
	_actions.append(action)
	action_appended.emit(action, _actions.size() - 1)

	_set_current_action()

## Get actions, don't modify the returned array
func get_actions() -> Array[Action]:
	return _actions


func _execute_action(tile):
	if not enabled:
		return

	var result = false
	var action : Action = get_front()

	if action:
		result = action.execute_action(tile)

	if !result:
		return

	_actions.pop_front()
	action_popped_at.emit(0)
	SignalBus.on_player_action.emit(GameGlobal.player, action)
	if !action.temporary:
		append(action)
	_set_current_action()

func _get_num_of_same_action(action: Action) -> int:
	var count: int = 0
	for a in _actions:
		if a.name == action.name:
			count += 1
	return count

func _try_pop_next(number: int) -> Action:
	if _actions.size() - 1 <= number:
		return null
	var action_to_pop: Action = _actions[number]
	if action_to_pop.keep_always_one and _get_num_of_same_action(action_to_pop) <= 1:
		return _try_pop_next(number + 1)
	action_popped_at.emit(number)
	return _actions.pop_at(number)

func _set_current_action():
	if _actions.size() == 0:
		current_action = null
		return
	current_action = _actions[0]
