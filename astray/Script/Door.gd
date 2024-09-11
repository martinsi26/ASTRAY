extends StaticBody2D

@onready var inv: Inv = preload("res://Inventory/Player_inv.tres")
@onready var door_key: InvItem = preload("res://Inventory/Items/Door_Key.tres")

var on_door = false

signal use_door_key

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func key_in_inv():
	for i in inv.slots.size():
		if inv.slots[i].item == door_key:
			return true
	return false
	
func _process(delta: float) -> void:
	if on_door and Input.is_action_just_pressed("Interact") and key_in_inv():
		$CollisionShape2D.disabled = true
		emit_signal("use_door_key")
		
func _on_hitbox_area_entered(area: Area2D) -> void:
	on_door = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	on_door = false
