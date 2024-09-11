extends RigidBody2D

@onready var inv: Inv = preload("res://Inventory/Player_inv.tres")
@onready var yarn: InvItem = preload("res://Inventory/Items/Yarn.tres")

var on_yarn = false

signal pickup_yarn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if yarn_in_inv():
		queue_free()
	
func yarn_in_inv():
	for i in inv.slots.size():
		if inv.slots[i].item == yarn:
			return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_yarn and Input.is_action_just_pressed("Interact"):
		pickup()

func pickup():
	emit_signal("pickup_yarn")
	queue_free()
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	on_yarn = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	on_yarn = false
