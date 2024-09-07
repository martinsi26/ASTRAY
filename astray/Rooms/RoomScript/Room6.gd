extends Node2D

signal enter_room5(current_room)
signal enter_room7(current_room)
signal enter_room8(current_room)

func _ready():
	get_node("TileMap/DownTree").enabled = false

func _on_to_room_7_area_entered(area: Area2D) -> void:
	emit_signal("enter_room7", 6)


func _on_to_room_8_area_entered(area: Area2D) -> void:
	emit_signal("enter_room8", 6)


func _on_to_room_5_area_entered(area: Area2D) -> void:
	emit_signal("enter_room5", 6)

