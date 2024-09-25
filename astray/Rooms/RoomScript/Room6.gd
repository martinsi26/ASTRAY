extends Node2D

signal enter_room5(current_room, to_room)
signal enter_room7(current_room, to_room)
signal enter_room8(current_room, to_room)

signal use_wood

var can_place_wood = false

func _ready():
	if Global.wood_placed:
		get_node("Bridge").enabled = true
		get_node("BlockPath").collision_layer = 0
		get_node("BlockPath").collision_mask = 0
		
func _process(delta: float) -> void:
	if can_place_wood and Input.is_action_just_pressed("Interact") and Global.wood_inv:
		get_node("Bridge").enabled = true
		get_node("BlockPath").collision_layer = 0
		get_node("BlockPath").collision_mask = 0
		emit_signal("use_wood")

func _on_place_wood_hitbox_area_entered(area: Area2D) -> void:
	can_place_wood = true

func _on_place_wood_hitbox_area_exited(area: Area2D) -> void:
	can_place_wood = false

func _on_to_room_7_area_entered(area: Area2D) -> void:
	emit_signal("enter_room7", 6, 7)

func _on_to_room_8_area_entered(area: Area2D) -> void:
	emit_signal("enter_room8", 6, 8)

func _on_to_room_5_area_entered(area: Area2D) -> void:
	emit_signal("enter_room5", 6, 5)
