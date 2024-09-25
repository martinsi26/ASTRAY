extends Node2D

var on_code = false

signal pickup_code(code_num)
signal start_dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.code4_inv:
		queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_code and Input.is_action_just_pressed("Interact") and Global.claw_inv:
		pickup()

func pickup():
	emit_signal("pickup_code", 4)
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	on_code = true
	
func _on_hitbox_area_exited(area: Area2D) -> void:
	on_code = false
