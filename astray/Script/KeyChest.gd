extends StaticBody2D

var dialogue = preload("res://Scene/Dialogue.tscn")

var chest_opened = false
var on_chest
var found_chest_dialogue

signal open_key_chest
signal start_dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_chest and Input.is_action_pressed("Interact") and Global.chest_key_inv:
		emit_signal("open_key_chest")
		$AnimatedSprite2D.play("OpenChest")

func _on_hitbox_area_entered(area: Area2D) -> void:
	if !chest_opened:
		chest_dialogue()
	on_chest = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	on_chest = false

func chest_dialogue():
	dialogue = [
		"You Found A Chest!",
		"Press 'E' With A Key"
	]
	emit_signal("start_dialogue", dialogue)
