extends Control

func _on_quit_button_pressed() -> void:
	#When quit button is pressed game quits
	get_tree().quit()


func _on_return_to_home_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/StartScreen.tscn")
	#Returns to home screen at the end of the game
