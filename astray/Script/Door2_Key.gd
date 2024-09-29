extends StaticBody2D

var on_key = false

signal pickup_key(key_num)
signal start_dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.door2_key_inv or Global.used_door2_key or Global.door2_open:
		queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_key:
		$AnimatedSprite2D.play("Rotate")
		if Input.is_action_just_pressed("Interact"):
			pickup()
		
func pickup():
	emit_signal("pickup_key", 2)
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	on_key = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	on_key = false
