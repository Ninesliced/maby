extends Control
class_name MainMenu

@onready var play: Control = %Play
var main_menu_scene : PackedScene = preload("res://scenes/main_game.tscn")
@onready var play_button: Button = %PlayCustomSeed
@onready var request: Node2D = %Request
@onready var play_seed_of_the_day: Button = %PlaySeedOfTheDay

var seed_of_the_day: String = ""
@export var tutorial_scene: PackedScene = preload("res://scenes/main_tuto.tscn")
@onready var leaderboards: Array[HBoxContainer] = [%Leaderboard, %Leaderboard2, %Leaderboard3, %Leaderboard4, %Leaderboard5]

@onready var main: VBoxContainer = %Main
func _ready():
	UIManager.first_unclosable = true
	UIManager._stack.clear() # HACK
	UIManager.set_ui(main, play_button)
	%Username.text = GameGlobal.username
	if GameGlobal.username != "":
		play_seed_of_the_day.is_username_valid = true
	if !GameGlobal.is_seed_of_the_day and GameGlobal.is_user_seed:
		%SeedInput.text = GameGlobal.rng_seed
		
func _on_play_pressed():
	UIManager.set_ui(play)
	request.get_seed()
	request.get_leaderboard()
	
func _on_quit_pressed():
	get_tree().quit()
	
func get_random_seed() -> String:
	var out = ""
	var possible_char = "azertyuiopqsdfghjklmwxcvbn1234567890"
	for i in range(12):
		out += possible_char[randi()%len(possible_char)]
	return out
	
func _on_play_button_pressed():
	var inputed_seed = $Play/Container/HBoxContainer/right/panel/VBoxContainer/NinePatchRect/SeedInput.text
	if inputed_seed == "":
		inputed_seed = get_random_seed()
	GameGlobal.is_user_seed = (%SeedInput.text != "")
	GameGlobal.rng_seed = inputed_seed
	GameGlobal.is_seed_of_the_day = false
	print(main_menu_scene.resource_name)
	TransitionManager.change_scene(main_menu_scene, "circle_gradient", null, 1.0)


func _on_tutorial_button_pressed():
	GameGlobal.is_seed_of_the_day = false
	TransitionManager.change_scene(tutorial_scene, "circle_gradient", null, 1.0)


func _on_play_seed_of_the_day_button_pressed() -> void:
	GameGlobal.is_seed_of_the_day = true
	GameGlobal.username = %Username.text
	if GameGlobal.username == "":
		GameGlobal.username = "Noob"
	# GameGlobal.music_manager.calfed = false
	#FIXME: music _manager
	TransitionManager.change_scene(main_menu_scene, "circle_gradient", null, 1.0)


func _on_refresh_button_pressed() -> void:
	%Request.get_leaderboard()


func _on_close_button_pressed() -> void:
	UIManager.close_ui()
