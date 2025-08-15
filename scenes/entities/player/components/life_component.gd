extends Node

@export var state_machine : StateMachine

func _on_hitbox_area_entered(area:Area2D) -> void:
    state_machine.set_state("Die")