extends StaticBody2D

@onready var inv: Inv = preload("res://Inventory/Player_inv.tres")
@onready var door_key: InvItem = preload("res://Inventory/Items/Door_Key.tres")
@onready var axe: InvItem = preload("res://Inventory/Items/Axe.tres")

var dialogue = preload("res://Scene/Dialogue.tscn")

var on_key = false

signal pickup_key
signal start_dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	if key_in_inv():
		queue_free()
	if axe_in_inv():
		queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_key and Input.is_action_just_pressed("Interact"):
		pickup()

func pickup():
	emit_signal("pickup_key")
	queue_free()
		
func key_in_inv():
	for i in inv.slots.size():
		if inv.slots[i].item == door_key:
			return true
	return false

func axe_in_inv():
	for i in inv.slots.size():
		if inv.slots[i].item == axe:
			return true
	return false

func _on_hitbox_area_entered(area: Area2D) -> void:
	on_key = true
	visible = true
	found_key_dialogue()
	
func _on_hitbox_area_exited(area: Area2D) -> void:
	on_key = false
	visible = false

func found_key_dialogue():
	dialogue = [
		"You Found A Key!",
		"Press 'E' To Pickup"
	]
	emit_signal("start_dialogue", dialogue)
