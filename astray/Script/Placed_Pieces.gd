extends Node2D

var on_circle = false

var texture = preload("res://Art/Images/puzzle piece 1.png")

signal place_piece(piece_num)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.puzzle_piece1_placed:
		$Puzzle_Piece1.texture = texture
	if Global.puzzle_piece2_placed:
		$Puzzle_Piece2.texture = texture
	if Global.puzzle_piece3_placed:
		$Puzzle_Piece3.texture = texture
	if Global.puzzle_piece4_placed:
		$Puzzle_Piece4.texture = texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_circle and Input.is_action_just_pressed("Interact"):
		if Global.puzzle_piece1_inv:
			$Puzzle_Piece1.texture = texture
			emit_signal("place_piece", 1)
		if Global.puzzle_piece2_inv:
			$Puzzle_Piece2.texture = texture
			emit_signal("place_piece", 2)
		if Global.puzzle_piece3_inv:
			$Puzzle_Piece3.texture = texture
			emit_signal("place_piece", 3)
		if Global.puzzle_piece4_inv:
			$Puzzle_Piece4.texture = texture
			emit_signal("place_piece", 4)
		
func _on_area_2d_area_entered(area: Area2D) -> void:
	on_circle = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	on_circle = false
