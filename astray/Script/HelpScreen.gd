extends Control

var action = false

func _on_return_button_pressed() -> void:
	if action:
		$".".visible = false
	else:
		get_tree().change_scene_to_file("res://Scene/StartScreen.tscn")

func _on_pause_menu_help_button() -> void:
	action = true
