extends CharacterBody2D

var dialogue = preload("res://Scene/Dialogue.tscn")

@onready var key_path: NodePath = "Room6/Key"
@onready var key_chest_path: NodePath = "Room6/KeyChest"

# character speed
var speed = 500

# items
@export var inv: Inv
@export var key: InvItem
@export var axe: InvItem
@export var puzzle_piece1: InvItem

# pushing items
var push_force = 40

# signals
signal start_dialogue
signal has_pickedup_key(pickedup_key)

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
	collect(key)
	open_pickup_key_dialogue()

func open_pickup_key_dialogue():
	dialogue = [
		"You Picked Up The Key!",
		"Now Find The Chest!"
	]
	emit_signal("start_dialogue", dialogue)

func open_chest():
	use(key)
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

func key_room() -> void:
	get_parent().get_node(key_path).connect("pickup_key", pickup_key)
	get_parent().get_node(key_chest_path).connect("open_key_chest", open_chest)
