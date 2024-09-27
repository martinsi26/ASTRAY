extends CharacterBody2D

var dialogue = preload("res://Scene/Dialogue.tscn")

@onready var door_key_path: NodePath = "Room1/Door_Key"
@onready var claw_path: NodePath = "Room4/Claw"
@onready var key_chest_path: NodePath = "Room3/KeyChest"
@onready var number_chest_path: NodePath = "Room5/NumberCodeChest/Number_Code_UI"
@onready var door_path: NodePath = "Room2/Door"
@onready var door2_key_path: NodePath = "Room0/Door2_Key"
@onready var code2_path: NodePath = "Room4/Code_Digit2"
@onready var code9_path: NodePath = "Room5/Code_Digit9"
@onready var code6_path: NodePath = "Room4/Code_Digit6"
@onready var code4_path: NodePath = "Room2/Code_Digit4"
@onready var audio_player = $AudioStreamPlayer2D

var is_walking = false
var step_timer = 0.0
var step_interval = 0.5  # Adjust for time between footstep sounds
# character speed
var speed = 300

@export var inv: Inv
# items
@export var chest_key: InvItem
@export var axe: InvItem
@export var yarn: InvItem
@export var claw: InvItem
@export var door_key: InvItem
@export var door2_key: InvItem
@export var code_digit6: InvItem
@export var code_digit9: InvItem
@export var code_digit4: InvItem
@export var code_digit2: InvItem
@export var puzzle_piece1: InvItem

var yarn_ball = preload("res://Scene/Yarn.tscn")

# pushing items
var push_force = 40

# signals
signal start_dialogue
signal move_ash
signal stop_moving
#signal has_pickedup_key(pickedup_key)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("Player")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Sprint"):
		speed = 500
	else:
		speed = 300
		
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
	
	if velocity.length() > 0.1:  # Character is moving
		if not is_walking:
			is_walking = true
			step_timer = 0.0  # Reset the timer when walking starts
		else:
			step_timer -= delta
			if step_timer <= 0:
				if audio_player:
					audio_player.play()  # Play the footstep sound
					print("Playing footstep sound")
				else:
					print("AudioStreamPlayer is not found!")
				step_timer = step_interval  # Reset the timer
	else:  # Character is idle (not moving)
		if is_walking:  # Only reset if we were walking previously
			is_walking = false
			step_timer = 0.0  # Stop the footsteps sound when the character stops walking
			if audio_player and audio_player.is_playing():
				audio_player.stop()  # Stop the sound if it's still playing

func drop_yarn():
	var cat = get_node(".")
	Global.yarn_inv = false
	use(yarn)
	
	Global.yarn_room = Global.room
	var ball_instance = yarn_ball.instantiate()
	get_parent().get_node(Global.yarn_room).add_child(ball_instance)
	
	if get_node("AnimatedSprite2D").flip_h:
		ball_instance.position.x = cat.position.x - 50
	else:
		ball_instance.position.x = cat.position.x + 70
	ball_instance.position.y = cat.position.y + 20
	
	if Global.yarn_room == "Room5":
		emit_signal("move_ash")
	
	get_parent().get_node(Global.yarn_room + "/Yarn").connect("pickup_yarn", pickup_yarn)
	
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

func pickup_key(key_num):
	if key_num == 1:
		collect(door_key)
		Global.door_key_inv = true
		open_pickup_key_dialogue()
	elif key_num == 2:
		collect(door2_key)
		Global.door2_key_inv = true
	
func pickup_yarn():
	if Global.yarn_room == "Room5":
		emit_signal("stop_moving")
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

func use_door_key(door_num):
	
	if door_num == 1:
		use(door_key)
		Global.door_open = true
		Global.door_key_inv = false
	elif door_num == 2:
		use(door2_key)
		Global.door2_open = true
		Global.door2_key_inv = false
	
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
	
func door2_key_room() -> void:
	get_parent().get_node(door2_key_path).connect("pickup_key", pickup_key)

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
	get_parent().get_node(code4_path).connect("pickup_code", pickup_code4)

func tree_room() -> void:
	get_parent().get_node("Room6").connect("use_axe", use_axe)

func yarn_room(yarn_path) -> void:
	get_parent().get_node(yarn_path).connect("pickup_yarn", pickup_yarn)
