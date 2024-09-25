extends Control

func _on_quit_button_pressed() -> void:
	#When quit button is pressed game quits
	get_tree().quit()


func _on_play_again_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/StartScreen.tscn")
