extends CharacterBody2D
class_name Player

@export var player_data: PlayerData

@onready var action_manager: ActionManager = %ActionManager
@onready var movement_component: MovementComponent = %MovementComponent
@onready var skill_component: SkillComponent = %SkillComponent

func _ready() -> void:
    GameGlobal.player = self


# HELPER METHODS

func has_any_action() -> bool:
    return action_manager.get_front() != null