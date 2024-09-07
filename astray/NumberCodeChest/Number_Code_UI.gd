extends Control

@onready var digit: NumberCode = preload("res://NumberCodeChest/Number_Code.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	digit.update.connect(update_slots)
	update_slots()
	close()
	
func update_slots():
	for i in range(min(digit.slots.size(), slots.size())):
		slots[i].update(digit.slots[i])
	
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
