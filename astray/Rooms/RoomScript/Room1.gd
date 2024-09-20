extends Node2D

signal enter_room0(current_room, to_room)
signal enter_room2(current_room, to_room)

func _on_to_room_0_area_entered(area: Area2D) -> void:
	emit_signal("enter_room0", 1, 0)


func _on_to_room_2_area_entered(area: Area2D) -> void:
	emit_signal("enter_room2", 1, 2)
