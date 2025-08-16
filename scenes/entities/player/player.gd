extends CharacterBody2D
class_name Player

@export var test_player_data: PlayerData

@export var player_data: PlayerData

@onready var action_manager: ActionManager = %ActionManager
@onready var movement_component: MovementComponent = %MovementComponent
@onready var skill_component: SkillComponent = %SkillComponent

func _ready() -> void:
    player_data = test_player_data.duplicate(true)
    player_data.skill = player_data.skill.duplicate(true)
    GameGlobal.player = self


# HELPER METHODS

func has_any_action() -> bool:
    return action_manager.get_front() != null

func _on_movement_component_on_move(direction:Vector2) -> void:
    var walk_sound_effect: AudioStreamPlayer = %WalkSoundEffect
    walk_sound_effect.pitch_scale = randf_range(0.8, 1.3)
    walk_sound_effect.play()