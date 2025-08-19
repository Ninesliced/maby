extends MarginContainer

@onready var character_name: Label = %CharacterName

@onready var action_vbox: HBoxContainer = %ActionVBox
@onready var character_texture: TextureRect = %CharacterTexture

@onready var skill_ui: SkillUI = %SkillUI
@onready var skill_name: Label = %SkillName
@onready var skill_description: Label = %SkillDescription


@onready var characters_vbox: VBoxContainer = $HBoxContainer/CharacterSelection/MarginContainer/HBoxContainer/MarginContainer/MarginContainer/CharactersVbox
@onready var up: Button = %Up
@onready var down: Button = %Down
var current_character_index: int = 0
var current_character: PlayerData

func _ready() -> void:
	if !Global.characters.is_empty():
		return
	


func _on_play_pressed() -> void:
	pass # Replace with function body.
