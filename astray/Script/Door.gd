extends StaticBody2D

var on_door = false

signal use_door_key(door_num)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.door_open:
		$CollisionShape2D.queue_free()
	
func _process(delta: float) -> void:
	if on_door and Input.is_action_just_pressed("Interact") and Global.door_key_inv:
		$CollisionShape2D.queue_free()
		emit_signal("use_door_key", 1)
		
func _on_hitbox_area_entered(area: Area2D) -> void:
	on_door = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	on_door = false
