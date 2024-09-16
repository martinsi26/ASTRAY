extends Node2D

signal enter_room1(current_room)
signal enter_room3(current_room)

func _ready() -> void:
	$Yarn.position.x = Global.yarn_posx
	$Yarn.position.y = Global.yarn_posy

func _on_to_room_1_area_entered(area: Area2D) -> void:
	if !Global.yarn_inv:
		Global.yarn_posx = $Yarn.position.x
		Global.yarn_posy = $Yarn.position.y
	emit_signal("enter_room1", 2)

func _on_to_room_3_area_entered(area: Area2D) -> void:
	if !Global.yarn_inv:
		Global.yarn_posx = $Yarn.position.x
		Global.yarn_posy = $Yarn.position.y
	emit_signal("enter_room3", 2)
