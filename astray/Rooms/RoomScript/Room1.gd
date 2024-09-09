extends Node2D

signal enter_room0(current_room)
signal enter_room2(current_room)

func _on_to_room_0_area_entered(area: Area2D) -> void:
	emit_signal("enter_Room0", 1)


func _on_to_room_2_area_entered(area: Area2D) -> void:
	emit_signal("enter_room2", 1)
