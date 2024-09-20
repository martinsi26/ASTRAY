extends Node2D

signal enter_room6(current_room, to_room)

func _on_to_room_6_area_entered(area: Area2D) -> void:
	emit_signal("enter_room6", 7, 6)
