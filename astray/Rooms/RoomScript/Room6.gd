extends Node2D

signal enter_room5(current_room)
signal enter_room7(current_room)
signal enter_room8(current_room)

signal use_axe

var on_tree = false

func _ready():
	if Global.tree_down:
		get_node("TileMap/DownTree").enabled = true
		get_node("TileMap/OriginalTree").enabled = false
		get_node("BlockPath/CollisionPolygon2D").disabled = true

func _on_to_room_7_area_entered(area: Area2D) -> void:
	emit_signal("enter_room7", 6)

func _on_to_room_8_area_entered(area: Area2D) -> void:
	emit_signal("enter_room8", 6)

func _on_to_room_5_area_entered(area: Area2D) -> void:
	emit_signal("enter_room5", 6)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_tree and Input.is_action_just_pressed("Interact") and Global.axe_inv:
		Global.tree_down = true
		get_node("TileMap/DownTree").enabled = true
		get_node("TileMap/OriginalTree").enabled = false
		get_node("BlockPath/CollisionPolygon2D").disabled = true
		get_node("StandingTree/CollisionPolygon2D").disabled = true
		# play animation of dust to give the idea that the tree is falling
		emit_signal("use_axe")

func _on_hitbox_area_entered(area: Area2D) -> void:
	on_tree = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	on_tree = false
