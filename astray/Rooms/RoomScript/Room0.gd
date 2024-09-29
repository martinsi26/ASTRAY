extends Node2D

signal enter_room1(current_room, to_room)

func _on_to_room_1_area_entered(area: Area2D) -> void:
	emit_signal("enter_room1", 0, 1)
	



func poster_dialogue():
	pass
	#dialogue = [
		#"Lost Kitten: Ash",
		#"Description: Small with black furr and green eyes."
	#]
	#emit_signal("start_dialogue", dialogue)


func _on_area_2d_area_entered(area: Area2D) -> void:
	poster_dialogue()
