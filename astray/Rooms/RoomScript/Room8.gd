extends Node2D

signal enter_room6(current_room, to_room)
signal enter_room9(current_room, to_room)
signal enter_room10(current_room, to_room)

func _on_to_room_6_area_entered(area: Area2D) -> void:
	emit_signal("enter_room6", 8, 6)

func _on_to_room_9_area_entered(area: Area2D) -> void:
	emit_signal("enter_room9", 8, 9)

func _on_to_room_10_area_entered(area: Area2D) -> void:
	#if (Global.puzzle_piece1_placed and Global.puzzle_piece2_placed
		#and Global.puzzle_piece3_placed and Global.puzzle_piece4_placed):
		emit_signal("enter_room10", 8, 10)
