extends Node2D

signal enter_room0(current_room, to_room)
signal enter_room2(current_room, to_room)

var can_enter = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("random_key"):
		can_enter = true
		print("Can enter is now: ", can_enter)
	else:
		can_enter = false

func _on_to_room_0_area_entered(area: Area2D) -> void:
	if can_enter:
		emit_signal("enter_room0", 1, 0)

func _on_to_room_2_area_entered(area: Area2D) -> void:
	emit_signal("enter_room2", 1, 2)
