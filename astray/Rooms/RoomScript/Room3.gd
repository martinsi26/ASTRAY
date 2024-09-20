extends Node2D

signal enter_room2(current_room, to_room)
signal enter_room4(current_room, to_room)
signal enter_room5(current_room, to_room)

func _on_to_room_5_area_entered(area: Area2D) -> void:
	emit_signal("enter_room5", 3, 5)


func _on_to_room_2_area_entered(area: Area2D) -> void:
	emit_signal("enter_room2", 3, 2)


func _on_to_room_4_area_entered(area: Area2D) -> void:
	emit_signal("enter_room4", 3, 4)
