extends Node2D

signal enter_room1(current_room, to_room)

func _on_to_room_1_area_entered(area: Area2D) -> void:
	emit_signal("enter_room1", 0, 1)
