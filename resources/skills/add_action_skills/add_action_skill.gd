extends SkillData
class_name AddActionSkill

@export var action: Action

func use_skill() -> bool:
    if cooldown > 0:
        return false
    var player: Player = GameGlobal.player
    if !player:
        return false
    player.action_manager.add_front(action, false)
    cooldown = max_cooldown
    SignalBus.on_player_skill.emit()
    return true