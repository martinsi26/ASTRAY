extends StaticBody2D

@onready var inv: Inv = preload("res://Inventory/Player_inv.tres")
@onready var puzzle_piece: InvItem = preload("res://Inventory/Items/Puzzle_Piece1.tres")
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var on_piece = false  
var on_puzzle_piece 
var found_puzzle_piece_dialogue

signal pickup_piece  
signal start_dialogue  

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Check if the puzzle piece is already in the player's inventory
	if piece_in_inv():
		queue_free()  
	else:
		animated_sprite.play("idle")  # Play the idle animation if not in inventory

# Function to pick up the puzzle piece and add it to the inventory
func pickup(): 
	emit_signal("pickup_piece")
	inv.add_item(puzzle_piece)  
	queue_free()  

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_piece and Input.is_action_just_pressed("Interact"):
		emit_signal("pickup_piece")

# Function to check if the puzzle piece is already in the player's inventory
func piece_in_inv():
	for i in inv.slots.size():
		if inv.slots[i].item == puzzle_piece:
			return true
	return false

# Called when the player enters the interaction area near the puzzle piece
func _on_area_2d_area_entered(area: Area2D) -> void:
	on_piece = true  
	animated_sprite.play("idle")  # Play idle animation when the player is nearby
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
