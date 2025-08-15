extends Control

@onready var label: Label = %Label

func _ready() -> void:
    SignalBus.on_score_changed.connect(_on_score_changed)
    _on_score_changed(0)  # Initialize with zero score

func _on_score_changed(score: int) -> void:
    label.text = str(score)
    label.text = "Score: " + str(score)