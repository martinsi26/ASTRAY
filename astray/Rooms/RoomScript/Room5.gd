extends Node2D

signal enter_room6(current_room, to_room)
signal enter_room3(current_room, to_room)

signal use_axe
signal pickup_wood

var on_tree = false
var on_wood = false

func _on_to_room_6_area_entered(area: Area2D) -> void:
	emit_signal("enter_room6", 5, 6)

func _on_to_room_3_area_entered(area: Area2D) -> void:
	emit_signal("enter_room3", 5, 3)
	
func _ready():
	if Global.axe_used:
		get_node("Cutting_Tree").enabled = false
		get_node("Cutting_Tree/Tree_Hitbox").monitoring = false
		if Global.wood_inv or Global.wood_placed:
			get_node("Wood").enabled = false
			get_node("Wood/Wood_Hitbox").monitoring = false
		elif !Global.wood_inv and !Global.wood_placed:
			get_node("Wood").enabled = true
			get_node("Wood/Wood_Hitbox").monitoring = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_tree and Input.is_action_just_pressed("Interact") and Global.axe_inv:
		get_node("Cutting_Tree").enabled = false
		get_node("Cutting_Tree/Tree_Hitbox").monitoring = false
		# play animation of dust to give the idea that the tree is falling
		emit_signal("use_axe")
		get_node("Wood").enabled = true
		get_node("Wood/Wood_Hitbox").monitoring = true
		
	if on_wood and Input.is_action_just_pressed("Interact"):
		get_node("Wood").enabled = false
		get_node("Wood/Wood_Hitbox").monitoring = false
		emit_signal("pickup_wood")

func _on_tree_hitbox_area_entered(area: Area2D) -> void:
	on_tree = true

func _on_tree_hitbox_area_exited(area: Area2D) -> void:
	on_tree = false

func _on_wood_hitbox_area_entered(area: Area2D) -> void:
	on_wood = true

func _on_wood_hitbox_area_exited(area: Area2D) -> void:
	on_wood = false
