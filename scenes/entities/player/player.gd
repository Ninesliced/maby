extends CharacterBody2D
class_name Player

@export var player_data: PlayerData

@onready var action_manager: ActionManager = %ActionManager
@onready var movement_component: MovementComponent = %MovementComponent

func _ready() -> void:
    GameGlobal.player = self