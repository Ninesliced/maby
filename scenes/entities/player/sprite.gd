extends AnimatedSprite2D



func _on_movement_component_on_idle() -> void:
    play("idle")
    pass # Replace with function body.

func _on_movement_component_on_move(direction:Vector2) -> void:
    if direction.x > 0:
        flip_h = false
    elif direction.x < 0:
        flip_h = true
    play("run")
    pass # Replace with function body.
