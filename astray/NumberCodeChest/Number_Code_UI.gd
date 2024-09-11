extends Control

@onready var image1: Sprite2D = get_node("NinePatchRect/GridContainer/Code_UI_Slot1/Sprite2D")
@onready var image2: Sprite2D = get_node("NinePatchRect/GridContainer/Code_UI_Slot2/Sprite2D")
@onready var image3: Sprite2D = get_node("NinePatchRect/GridContainer/Code_UI_Slot3/Sprite2D")
@onready var image4: Sprite2D = get_node("NinePatchRect/GridContainer/Code_UI_Slot4/Sprite2D")

@onready var number1: Label = get_node("NinePatchRect/GridContainer/Code_UI_Slot1/CenterContainer/Panel/NumberSelected")
@onready var number2: Label = get_node("NinePatchRect/GridContainer/Code_UI_Slot2/CenterContainer/Panel/NumberSelected")
@onready var number3: Label = get_node("NinePatchRect/GridContainer/Code_UI_Slot3/CenterContainer/Panel/NumberSelected")
@onready var number4: Label = get_node("NinePatchRect/GridContainer/Code_UI_Slot4/CenterContainer/Panel/NumberSelected")

@onready var digit: NumberCode = preload("res://NumberCodeChest/Number_Code.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

@onready var inv: Inv = preload("res://Inventory/Player_inv.tres")
@onready var chest_key: InvItem = preload("res://Inventory/Items/Chest_Key.tres")
@onready var axe: InvItem = preload("res://Inventory/Items/Axe.tres")

var is_open = false

signal open_number_chest

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	image1.modulate = Color(0, 0, 1)
	image2.modulate = Color(0, 1, 0)
	image3.modulate = Color(1, 0, 0)
	image4.modulate = Color(0, 0, 0)
	
	digit.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(digit.slots.size(), slots.size())):
		slots[i].update(digit.slots[i])
	
	if (digit.slots[0].value == 6 and digit.slots[1].value == 9 
		and digit.slots[2].value == 2 and digit.slots[3].value == 4):
		emit_signal("open_number_chest")
		disable_buttons()

func disable_buttons():
	$NinePatchRect/GridContainer/Code_UI_Slot1/CenterContainer/Panel/ButtonLeft.disabled = true
	$NinePatchRect/GridContainer/Code_UI_Slot1/CenterContainer/Panel/ButtonRight.disabled = true
	$NinePatchRect/GridContainer/Code_UI_Slot2/CenterContainer/Panel/ButtonLeft.disabled = true
	$NinePatchRect/GridContainer/Code_UI_Slot2/CenterContainer/Panel/ButtonRight.disabled = true
	$NinePatchRect/GridContainer/Code_UI_Slot3/CenterContainer/Panel/ButtonLeft.disabled = true
	$NinePatchRect/GridContainer/Code_UI_Slot3/CenterContainer/Panel/ButtonRight.disabled = true
	$NinePatchRect/GridContainer/Code_UI_Slot4/CenterContainer/Panel/ButtonLeft.disabled = true
	$NinePatchRect/GridContainer/Code_UI_Slot4/CenterContainer/Panel/ButtonRight.disabled = true
	
	
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
