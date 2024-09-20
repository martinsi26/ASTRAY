extends Node2D

signal enter_room3(current_room, to_room)

func _on_to_room_3_area_entered(area: Area2D) -> void:
	print("emitting signal")
	emit_signal("enter_room3", 4, 3)
