extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/Item_Display
@onready var slot = $"."

@onready var claw_texture: Texture = preload("res://Art/New_Assets/Claw.png")
@onready var door_key_texture: Texture = preload("res://Art/Images/icon.svg")
@onready var door2_key_texture: Texture = preload("res://Art/Images/icon.svg")
@onready var chest_key_texture: Texture = preload("res://Art/Images/icon.svg")
@onready var axe_texture: Texture = preload("res://Art/New_Assets/Axe.png")
@onready var wood_texture: Texture = preload("res://Art/Images/Wood.png")
@onready var yarn_texture: Texture = preload("res://Art/Images/yarn.png")
@onready var code_digit2_texture: Texture = preload("res://Art/Images/number2.png")
@onready var code_digit4_texture: Texture = preload("res://Art/Images/number4.png")
@onready var code_digit6_texture: Texture = preload("res://Art/Images/number6.png")
@onready var code_digit9_texture: Texture = preload("res://Art/Images/number9.png")
@onready var puzzle_piece1_texture: Texture = preload("res://Art/Images/puzzle piece 1.png")
@onready var puzzle_piece2_texture: Texture = preload("res://Art/Images/puzzle piece 1.png")
@onready var puzzle_piece3_texture: Texture = preload("res://Art/Images/puzzle piece 1.png")
@onready var puzzle_piece4_texture: Texture = preload("res://Art/Images/puzzle piece 1.png")

var item_name
var item_tip
var empty = true

func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
		empty = true
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		item_name = slot.item.name
		item_tip = slot.item.tip
		empty = false
		
		# Axe texture size
		if item_visual.texture == axe_texture:
			item_visual.scale = Vector2(0.2, 0.2)
		
		# Claw texture size
		if item_visual.texture == claw_texture:
			item_visual.scale = Vector2(1.5, 1.5)
		
		# Wood texture size
		if item_visual.texture == wood_texture:
			item_visual.scale = Vector2(0.125, 0.125)
		
		# Yarn texture size
		elif item_visual.texture == yarn_texture:
			item_visual.scale = Vector2(0.125, 0.125)
			
		# Door key texture size
		elif item_visual.texture == door_key_texture:
			item_visual.scale = Vector2(0.1, 0.1)
			
		# Door 2 key texture size
		elif item_visual.texture == door2_key_texture:
			item_visual.scale = Vector2(0.1, 0.1)
		
		# Chest key texture size
		elif item_visual.texture == chest_key_texture:
			item_visual.scale = Vector2(0.1, 0.1)
			
		# Code digit 2 texture size
		elif item_visual.texture == code_digit2_texture:
			item_visual.scale = Vector2(0.05, 0.05)
		
		# Code digit 4 texture size
		elif item_visual.texture == code_digit4_texture:
			item_visual.scale = Vector2(0.05, 0.05)
			
		# Code digit 6 texture size
		elif item_visual.texture == code_digit6_texture:
			item_visual.scale = Vector2(0.05, 0.05)
			
		# Code digit 9 texture size
		elif item_visual.texture == code_digit9_texture:
			item_visual.scale = Vector2(0.05, 0.05)
		
		# Puzzle pice 1 texture size
		elif item_visual.texture == puzzle_piece1_texture:
			item_visual.scale = Vector2(0.5, 0.5)
		
		# Puzzle pice 2 texture size
		elif item_visual.texture == puzzle_piece2_texture:
			item_visual.scale = Vector2(0.5, 0.5)
			
		# Puzzle pice 3 texture size
		elif item_visual.texture == puzzle_piece3_texture:
			item_visual.scale = Vector2(0.5, 0.5)
			
		# Puzzle pice 4 texture size
		elif item_visual.texture == puzzle_piece4_texture:
			item_visual.scale = Vector2(0.5, 0.5)
			
func _on_mouse_entered() -> void:
	emit_signal("mouse_entered", slot, item_name, item_tip, empty)
