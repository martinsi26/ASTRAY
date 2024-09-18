extends CharacterBody2D

var dialogue = preload("res://Scene/Dialogue.tscn")

@onready var yarn_path: NodePath = "Room2/Yarn"
@onready var door_key_path: NodePath = "Room1/Door_Key"
@onready var claw_path: NodePath = "Room4/Claw"
@onready var key_chest_path: NodePath = "Room3/KeyChest"
@onready var number_chest_path: NodePath = "Room5/NumberCodeChest/Number_Code_UI"
@onready var door_path: NodePath = "Room2/Door"
@onready var code2_path: NodePath = "Room4/Code_Digit2"
@onready var code9_path: NodePath = "Room5/Code_Digit9"
@onready var code6_path: NodePath = "Room4/Code_Digit6"
@onready var code4_path: NodePath = "Room2/Code_Digit4"

# character speed
var speed = 500

@export var inv: Inv
# items
@export var chest_key: InvItem
@export var axe: InvItem
@export var yarn: InvItem
@export var claw: InvItem
@export var door_key: InvItem
@export var code_digit6: InvItem
@export var code_digit9: InvItem
@export var code_digit4: InvItem
@export var code_digit2: InvItem
@export var puzzle_piece1: InvItem

# pushing items
var push_force = 40

# signals
signal start_dialogue
#signal has_pickedup_key(pickedup_key)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	
	if direction.x == 0 and direction.y == 0:
		# idle
		$AnimatedSprite2D.play("Idle")
	if direction.x != 0 or direction.y != 0:
		# walking
		$AnimatedSprite2D.play("Walk")
	if direction.x > 0:
		#face left
		get_node("AnimatedSprite2D").flip_h = false
		$HitboxRight.disabled = false
		$HitboxLeft.disabled = true
	elif direction.x < 0:
		#face right
		get_node("AnimatedSprite2D").flip_h = true
		$HitboxRight.disabled = true
		$HitboxLeft.disabled = false
	velocity = direction * speed
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

func pickup_code2():
	collect(code_digit2)
	Global.code1_inv = true
	
func pickup_code4():
	collect(code_digit4)
	Global.code2_inv = true
	
func pickup_code6():
	collect(code_digit6)
	Global.code3_inv = true
	
func pickup_code9():
	collect(code_digit9)
	Global.code4_inv = true

func pickup_key():
	collect(door_key)
	Global.door_key_inv = true
	open_pickup_key_dialogue()
	
func pickup_yarn():
	collect(yarn)
	Global.yarn_inv = true
	
func pickup_claw():
	collect(claw)
	Global.claw_inv = true

func open_pickup_key_dialogue():
	dialogue = [
		"You Picked Up The Key!",
		"Now Find The Door!"
	]
	emit_signal("start_dialogue", dialogue)

func use_door_key():
	use(door_key)
	Global.door_open = true
	Global.door_key_inv = false
	
func use_axe():
	Global.tree_down = true
	use(axe)
	Global.axe_inv = false
	Global.axe_used = true

func open_number_chest():
	collect(chest_key)
	Global.chest_key_inv = true
	
func open_key_chest():
	use(chest_key)
	Global.used_chest_key = true
	Global.chest_key_inv = false
	
	open_key_chest_dialogue()
	
	collect(axe)
	Global.axe_inv = true
	

func open_key_chest_dialogue():
	dialogue = [
		"The Chest Is Open!",
		"You Got An Axe!"
	]
	emit_signal("start_dialogue", dialogue)
		
func collect(item):
	inv.insert(item)

func use(item):
	inv.remove(item)
	
func door_key_room() -> void:
	get_parent().get_node(door_key_path).connect("pickup_key", pickup_key)

func key_chest_room() -> void:
	get_parent().get_node(key_chest_path).connect("open_key_chest", open_key_chest)
	
func number_chest_room() -> void:
	get_parent().get_node(number_chest_path).connect("open_number_chest", open_number_chest)
	get_parent().get_node(code9_path).connect("pickup_code", pickup_code9)

func claw_room() -> void:
	get_parent().get_node(claw_path).connect("pickup_claw", pickup_claw)
	get_parent().get_node(code2_path).connect("pickup_code", pickup_code2)
	get_parent().get_node(code6_path).connect("pickup_code", pickup_code6)

func door_room() -> void:
	get_parent().get_node(door_path).connect("use_door_key", use_door_key)
	get_parent().get_node(yarn_path).connect("pickup_yarn", pickup_yarn)
	get_parent().get_node(code4_path).connect("pickup_code", pickup_code4)

func tree_room() -> void:
	get_parent().get_node("Room6").connect("use_axe", use_axe)
