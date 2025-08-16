extends Action
class_name SingleTileAction

@export var tile_to_transform: PackedScene

func execute_action(tile: Tile) -> bool:
	if super(tile) == false:
		return false
	var map = GameGlobal.map
	assert(map != null, "Map is not initialized")

	tile.transform_to_another_type(tile_to_transform, true)
	Audio.short_explosion_sound_effect.play()
	return true
