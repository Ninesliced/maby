extends MarginContainer

@onready var character_name: Label = %CharacterName

var action_ui_scene: PackedScene = preload("res://scenes/ui/action_list/action_ui.tscn")
@onready var action_vbox: HBoxContainer = %ActionVBox
@onready var character_texture: TextureRect = %CharacterTexture

@onready var skill_ui: SkillUI = %SkillUI
@onready var skill_name: Label = %SkillName
@onready var skill_description: Label = %SkillDescription


@onready var character_button_scene = preload("res://scenes/ui/main_menu/CharacterSelection/character_button.tscn")
@onready var characters_vbox: VBoxContainer = $HBoxContainer/CharacterSelection/MarginContainer/HBoxContainer/MarginContainer/MarginContainer/CharactersVbox
@onready var up: Button = %Up
@onready var down: Button = %Down
var character_buttons: Array[Button] = []

var main_menu_scene : PackedScene = load("res://scenes/main_game.tscn")


var current_character_index: int = 0:
	set(value):
		value = value % character_buttons.size()
		current_character_index = value
		set_character(current_character_index)

var current_character: PlayerData

func _ready() -> void:
	if Global.characters.is_empty():
		return
	for i in range(Global.characters.size()):
		var character_button: Button = character_button_scene.instantiate()
		var set_character_func = func set_character_index() -> void:
			current_character_index = i
		character_button.pressed.connect(set_character_func)
		characters_vbox.add_child(character_button)
		character_buttons.append(character_button)
	
	characters_vbox.move_child(down, characters_vbox.get_child_count() - 1)

	current_character_index = 0

func _on_play_pressed() -> void:
	TransitionManager.change_scene(main_menu_scene, "circle_gradient", null, 1.0)

func _on_up_pressed() -> void:
	current_character_index -= 1


func _on_down_pressed() -> void:
	current_character_index += 1

func uncheck_all_buttons() -> void:
	for button in character_buttons:
		button.button_pressed = false


func set_character(index: int) -> void:
	current_character = Global.characters[index]
	character_name.text = current_character.name
	character_texture.texture = current_character.icon

	skill_ui.skill_icon.texture = current_character.skill.icon
	skill_name.text = current_character.skill.name
	skill_description.text = current_character.skill.description

	for child in action_vbox.get_children():
		child.queue_free()

	_update_buttons(index)
	_update_actions()

	# Game
	GameGlobal.player_data = current_character.duplicate(true)
	


func _update_buttons(index: int) -> void:
	uncheck_all_buttons()
	print(character_buttons.size())
	if character_buttons.size() > index:
		character_buttons[index].button_pressed = true

func _update_actions() -> void:
	for action in current_character.actions:
		var action_ui: ActionUI = action_ui_scene.instantiate()
		action_vbox.add_child(action_ui)
		action_ui.set_texture(action.texture)
		action_ui.play_add()
