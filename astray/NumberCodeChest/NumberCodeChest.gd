extends StaticBody2D

var dialogue = preload("res://Scene/Dialogue.tscn")

var on_chest
var chest_open = false
var close_chest = false
var found_chest_dialogue

signal open_number_code
signal close_number_code
signal start_dialogue

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.puzzle_piece4:
		chest_open = true
		close_chest = false
		$AnimatedSprite2D.animation = "CloseChest"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_chest and Input.is_action_pressed("Interact") and !chest_open:
		chest_open = true
		$AnimatedSprite2D.play("OpenChest")
		emit_signal("open_number_code")
	else:
		if close_chest:
			close_chest = false
			$AnimatedSprite2D.play("CloseChest")
			

func _on_hitbox_area_entered(area: Area2D) -> void:
	if !chest_open:
		chest_dialogue()
	on_chest = true
	
func _on_hitbox_area_exited(area: Area2D) -> void:
	on_chest = false
	if !Global.chest_key_inv:
		chest_open = false
		close_chest = true
	emit_signal("close_number_code")

func chest_dialogue():
	dialogue = [
		"You Found A Chest!",
		"Press 'E' To Interact"
	]
	emit_signal("start_dialogue", dialogue)
