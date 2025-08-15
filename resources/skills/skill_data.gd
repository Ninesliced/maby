extends Resource
class_name SkillData

@export var name: String
@export var description: String
@export var icon: Texture2D
@export var cooldown: int = 0
@export var max_cooldown: int = 5

func use_skill() -> bool:
    return true

func decrease_cooldown(number :int) -> void:
    if cooldown > 0:
        cooldown -= number
        if cooldown < 0:
            cooldown = 0