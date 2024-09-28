extends StaticBody2D

var dialogue = preload("res://Scene/Dialogue.tscn")

var on_key = false

signal pickup_key(key_num)
signal start_dialogue
@onready var audio_player = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	if Global.door_key_inv or Global.used_door_key or Global.door_open:
		queue_free()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_key:
		$AnimatedSprite2D.play("Rotate")
		if Input.is_action_just_pressed("Interact"):
			pickup()
		

func pickup():
	emit_signal("pickup_key", 1)
	queue_free()

func _on_hitbox_area_entered(area: Area2D) -> void:
	on_key = true
	visible = true
	audio_player.play()
	found_key_dialogue()
	
func _on_hitbox_area_exited(area: Area2D) -> void:
	on_key = false
	visible = false
	audio_player.stop()

func found_key_dialogue():
	dialogue = [
		"You Found A Key!",
		"Press 'E' To Pickup"
	]
	emit_signal("start_dialogue", dialogue)
