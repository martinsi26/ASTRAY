extends Control



func _on_start_button_pressed() -> void:
	#changing scene when start button is pressed to main
	get_tree().change_scene_to_file("res://Scene/Main.tscn")
	
	


func _on_quit_button_pressed() -> void:
	#When quit button is pressed game quits
	get_tree().quit()
	


func _on_help_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scene/HelpScreen.tscn")
