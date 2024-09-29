extends Node2D


var dialogue = preload("res://Scene/Dialogue.tscn")

signal start_dialogue
signal enter_room1(current_room, to_room)

func _on_to_room_1_area_entered(area: Area2D) -> void:
	emit_signal("enter_room1", 0, 1)
	
func poster_dialogue():
	dialogue = [
		"Lost Kitten: Ash",
		"Description: Small with black furr and green eyes."
	]
	emit_signal("start_dialogue", dialogue)
