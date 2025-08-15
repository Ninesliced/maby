extends SkillData
class_name AddActionSkill

@export var action: Action

func use_skill() -> bool:
    print("Using AddActionSkill")
    if cooldown > 0:
        print("Skill is on cooldown:", cooldown)
        return false
    var player: Player = GameGlobal.player
    if !player:
        print("No player found")
        return false
    print("true")
    player.action_manager.add_front(action, false)
    cooldown = max_cooldown
    SignalBus.on_player_skill.emit()
    return true