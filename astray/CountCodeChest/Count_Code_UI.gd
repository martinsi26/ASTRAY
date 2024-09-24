extends Control

@onready var image1: Sprite2D = get_node("NinePatchRect/GridContainerImages/Count_UI_Image1/CenterContainer/Panel/Sprite2D")
@onready var texture1: Texture = preload("res://Art/New_Assets/apple.png")
@onready var image2: Sprite2D = get_node("NinePatchRect/GridContainerImages/Count_UI_Image2/CenterContainer/Panel/Sprite2D")
@onready var texture2: Texture = preload("res://Art/New_Assets/banana.png")
@onready var image3: Sprite2D = get_node("NinePatchRect/GridContainerImages/Count_UI_Image3/CenterContainer/Panel/Sprite2D")
@onready var texture3: Texture = preload("res://Art/New_Assets/orange.png")
@onready var image4: Sprite2D = get_node("NinePatchRect/GridContainerImages/Count_UI_Image4/CenterContainer/Panel/Sprite2D")
@onready var texture4: Texture = preload("res://Art/New_Assets/peach.png")

@onready var digit: CountCode = preload("res://CountCodeChest/Count_Code.tres")
@onready var slots: Array = $NinePatchRect/GridContainerNumbers.get_children()

@onready var inv: Inv = preload("res://Inventory/Player_inv.tres")
@onready var claw: InvItem = preload("res://Inventory/Items/Claw.tres")

var is_open = false

signal open_count_chest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image1.scale = Vector2(2, 2)
	image2.scale = Vector2(2, 2)
	image3.scale = Vector2(2, 2)
	image4.scale = Vector2(2, 2)
	image1.texture = texture1
	image2.texture = texture2
	image3.texture = texture3
	image4.texture = texture4
	digit.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(digit.slots.size(), slots.size())):
		slots[i].update(digit.slots[i])
		
	if (digit.slots[0].value == 9 and digit.slots[1].value == 4 
		and digit.slots[2].value == 6 and digit.slots[3].value == 2):
		emit_signal("open_number_chest")
		#disable_buttons()
	
func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Exit") and is_open:
		close()
	
func open_number_code() -> void:
	if !is_open:
		open()
		
func close_number_code() -> void:
	if is_open:
		close()
