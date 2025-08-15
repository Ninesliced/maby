extends Node
class_name SkillComponent

var skill: SkillData

signal on_skill_used()
signal on_skill_cooldown_changed(cooldown: int)
signal on_skill_ready()
signal on_cooldown()

func _ready() -> void:
	var player: Player = get_parent()
	assert(player is Player, "SkillComponent must be a child of Player")
	skill = player.player_data.skill
	SignalBus.on_player_action.connect(_on_player_action_performed)
	
func _on_player_action_performed(player: Player, action: Action) -> void:
	print("SkillComponent: Player action performed")
	skill.decrease_cooldown(1)
	on_skill_cooldown_changed.emit(skill.cooldown)
	if skill.cooldown <= 0:
		on_skill_ready.emit()


func use_skill() -> void:
	var res = skill.use_skill()
	if !res:
		return
	on_skill_used.emit()
	if skill.cooldown > 0:
		on_cooldown.emit()
