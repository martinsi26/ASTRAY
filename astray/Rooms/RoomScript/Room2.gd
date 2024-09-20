extends Node2D

signal enter_room1(current_room, to_room)
signal enter_room3(current_room, to_room)

func _ready() -> void:
	pass

func _on_to_room_1_area_entered(area: Area2D) -> void:
	emit_signal("enter_room1", 2, 1)

func _on_to_room_3_area_entered(area: Area2D) -> void:
	emit_signal("enter_room3", 2, 3)
