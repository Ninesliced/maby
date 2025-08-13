extends Node
class_name ActionManager

var player_data: PlayerData

var _actions: Array[Action] = []

signal action_popped_front(action: Action)
signal action_appended(action: Action)
signal action_set(actions: Array[Action])

func _ready():
    var player: Player = get_parent()
    if not player:
        assert(false, "ActionManager must be a child of Player.")
    if !player.player_data:
        assert(false, "Player has no PlayerData assigned.")
    _actions = player_data.actions
    action_set.emit(_actions)


# PUBLIC METHODS

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

## execute the first action in the queue
## If the action is temporary, it will not be appended back to the queue
func execute_action():
    var action : Action = pop_front()
    if action:
        action.execute_action()
    
    if action.temporary:
        return
    append(action)