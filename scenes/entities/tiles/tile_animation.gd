extends AnimationPlayer

func play_full(delay: float = 0.0, blend = -1.0) -> void:
	if delay > 0.0:
		await get_tree().create_timer(delay).timeout
	play("full", blend)
