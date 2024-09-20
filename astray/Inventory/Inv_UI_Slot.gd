extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/Item_Display
@onready var slot = $"."

@onready var axe_texture: Texture = preload("res://Art/Images/axe.png")
@onready var yarn_texture: Texture = preload("res://Art/Images/yarn.png")

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
			item_visual.scale.x = 0.7
			item_visual.scale.y = 0.7
		
		# Yarn texture size
		elif item_visual.texture == yarn_texture:
			item_visual.scale.x = 0.025
			item_visual.scale.y = 0.025


func _on_mouse_entered() -> void:
	emit_signal("mouse_entered", slot, item_name, item_tip, empty)
