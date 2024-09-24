extends Node2D

signal enter_room8(current_room, to_room)
signal ending

func _on_to_room_8_area_entered(area: Area2D) -> void:
	emit_signal("enter_room8", 9, 8)

func _on_ending_area_entered(area: Area2D) -> void:
	emit_signal("ending")
