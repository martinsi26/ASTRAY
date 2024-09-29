extends Node2D


var dialogue = preload("res://Scene/Dialogue.tscn")

signal start_dialogue
signal enter_room3(current_room, to_room)

func _on_to_room_3_area_entered(area: Area2D) -> void:
	emit_signal("enter_room3", 4, 3)

func mouse_dialogue():
	dialogue = [
		"Look! a cat toy...",
		"I wonder whos' it is..."
	]
	emit_signal("start_dialogue", dialogue)


func _on_mouse_area_area_entered(area: Area2D) -> void:
	mouse_dialogue()
