extends Control


func _ready():
	hide()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if visible:
			resume_game()
		else:
			pause_game()
			

func _on_main_menu_button_pressed():
	Global.go_to_main_menu()
	resume_game()
	pass # Replace with function body.


func _on_resume_button_pressed():
	resume_game()
	pass # Replace with function body.


func resume_game():
	get_tree().paused = false
	hide()
	pass # Replace with function body.

func pause_game():
	get_tree().paused = true
	show()
	pass # Replace with function body.
