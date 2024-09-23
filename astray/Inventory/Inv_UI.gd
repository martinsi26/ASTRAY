extends Control

@onready var inv: Inv = preload("res://Inventory/Player_inv.tres")
@onready var slots: Array = $NinePatchRect/GridContainer.get_children()
@onready var tool_tip = $ToolTip
@onready var tool_tip_name = $ToolTip/NinePatchRect2/VBoxContainer/ItemName
@onready var tip = $ToolTip/NinePatchRect2/VBoxContainer/Tip

var is_open = false
var on_yarn = false

signal drop_yarn

func _ready():
	inv.update.connect(update_slots)
	update_slots()
	close()
	
	for i in slots:
		i.connect("mouse_entered", mouse_entered)
		i.connect("mouse_exited", mouse_exited)
	
func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])
	
func _process(delta):
	if Input.is_action_just_pressed("Open_Inv"):
		if is_open:
			close()
		else:
			open()
	if on_yarn and Input.is_action_just_pressed("Interact"):
		emit_signal("drop_yarn")
		on_yarn = false

func open():
	visible = true
	is_open = true
	
func close():
	visible = false
	is_open = false

func mouse_entered(slot, item_name, item_tip, empty):
	on_yarn = false
	if !empty:
		tool_tip.visible = true
		tool_tip.position.x = slot.position.x - 20
		tool_tip_name.text = item_name
		tip.text = item_tip
		if item_name == "Yarn Ball":
			on_yarn = true

func mouse_exited() -> void:
	tool_tip.visible = false
	on_yarn = false
