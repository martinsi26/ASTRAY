extends CharacterBody2D

var dialogue = preload("res://Scene/Dialogue.tscn")

@onready var yarn_path: NodePath = "Room2/Yarn"
@onready var door_key_path: NodePath = "Room1/Door_Key"
@onready var claw_path: NodePath = "Room4/Claw"
@onready var key_chest_path: NodePath = "Room3/KeyChest"
@onready var number_chest_path: NodePath = "Room5/NumberCodeChest/Number_Code_UI"
@onready var door_path: NodePath = "Room2/Door"

# character speed
var speed = 500

# items
@export var inv: Inv
@export var chest_key: InvItem
@export var axe: InvItem
@export var yarn: InvItem
@export var claw: InvItem
@export var door_key: InvItem
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
		pass
	if direction.x != 0 or direction.y != 0:
		# walking
		pass
		
	velocity = direction * speed
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
	
func pickup_key():
	collect(door_key)
	open_pickup_key_dialogue()
	
func pickup_yarn():
	collect(yarn)
	
func pickup_claw():
	collect(claw)

func open_pickup_key_dialogue():
	dialogue = [
		"You Picked Up The Key!",
		"Now Find The Door!"
	]
	emit_signal("start_dialogue", dialogue)

func use_door_key():
	use(door_key)

func open_number_chest():
	print("pickup chest key")
	collect(chest_key)
	
func open_key_chest():
	use(chest_key)
	open_key_chest_dialogue()
	collect(axe)

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

func claw_room() -> void:
	get_parent().get_node(claw_path).connect("pickup_claw", pickup_claw)

func door_room() -> void:
	get_parent().get_node(door_path).connect("use_door_key", use_door_key)
	get_parent().get_node(yarn_path).connect("pickup_yarn", pickup_yarn)
