extends Panel

@onready var item_visual: Sprite2D = $CenterContainer/Panel/Item_Display

@onready var axe_texture: Texture = preload("res://Art/Images/axe.png")
@onready var yarn_texture: Texture = preload("res://Art/Images/yarn.png")

func update(slot: InvSlot):
	if !slot.item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = slot.item.texture
		
		# Axe texture size
		if item_visual.texture == axe_texture:
			item_visual.scale.x = 0.7
			item_visual.scale.y = 0.7
		
		# Yarn texture size
		elif item_visual.texture == yarn_texture:
			item_visual.scale.x = 0.025
			item_visual.scale.y = 0.025
