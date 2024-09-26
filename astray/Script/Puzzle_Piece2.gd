extends StaticBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var on_piece = false  
var found_puzzle_piece_dialogue

signal pickup_piece(piece_num)
signal start_dialogue  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.puzzle_piece2_inv:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_piece:
		animated_sprite.play("idle")  # Play idle animation when the player is nearby
		if Input.is_action_just_pressed("Interact") and Global.claw_inv:
			pickup()
	else:
		animated_sprite.stop()
		
# Function to pick up the puzzle piece and add it to the inventory
func pickup(): 
	emit_signal("pickup_piece", 2)
	queue_free()  

# Called when the player enters the interaction area near the puzzle piece
func _on_area_2d_area_entered(area: Area2D) -> void:
	on_piece = true
	piece_dialogue()

# Called when the player exits the interaction area near the puzzle piece
func _on_area_2d_area_exited(area: Area2D) -> void:
	on_piece = false

# Function to display the dialogue when the player is near the puzzle piece
func piece_dialogue():
	var dialogue = [
		"You Found A Puzzle Piece!",
		"Press 'E' To Pick Up"
	]
	emit_signal("start_dialogue", dialogue)
