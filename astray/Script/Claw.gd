extends StaticBody2D

@onready var inv: Inv = preload("res://Inventory/Player_inv.tres")
@onready var claw: InvItem = preload("res://Inventory/Items/Claw.tres")

var on_claw = false

signal pickup_claw

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if claw_in_inv():
		queue_free()

func pickup():
	emit_signal("pickup_claw")
	queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_claw and Input.is_action_just_pressed("Interact"):
		pickup()

func claw_in_inv():
	for i in inv.slots.size():
		if inv.slots[i].item == claw:
			return true
	return false

func _on_area_2d_area_entered(area: Area2D) -> void:
	on_claw = true
