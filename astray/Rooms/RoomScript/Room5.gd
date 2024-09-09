extends Node2D

signal enter_room6(current_room)
signal enter_room3(current_room)

func _on_to_room_6_area_entered(area: Area2D) -> void:
	emit_signal("enter_room6", 5)


func _on_to_room_3_area_entered(area: Area2D) -> void:
	emit_signal("enter_room3", 5)
