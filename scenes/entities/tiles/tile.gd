extends Node2D
class_name Tile

func _on_mouse_area_input_event(viewport:Node, event:InputEvent, shape_idx:int) -> void:
    if event is InputEventMouseButton:
        if !event.pressed and event.button_index < 3:
            SignalBus.tile_clicked.emit(self)
            pass