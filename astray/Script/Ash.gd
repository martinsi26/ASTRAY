extends CharacterBody2D

var dialogue = preload("res://Scene/Dialogue.tscn")

var is_walking = false
var step_timer = 0.0
var step_interval = 0.5  # Adjust for time between footstep sounds
# character speed
var speed = 300

@export var inv: Inv
# items
@export var chest_key: InvItem
@export var axe: InvItem
@export var wood: InvItem
@export var yarn: InvItem
@export var claw: InvItem
@export var door_key: InvItem
@export var door2_key: InvItem
@export var code_digit6: InvItem
@export var code_digit9: InvItem
@export var code_digit4: InvItem
@export var code_digit2: InvItem
@export var puzzle_piece1: InvItem
@export var puzzle_piece2: InvItem
@export var puzzle_piece3: InvItem
@export var puzzle_piece4: InvItem

@onready var audio_player = $AudioStreamPlayer2D

var yarn_ball = preload("res://Scene/Yarn.tscn")

# pushing items
var push_force = 40

# signals
signal start_dialogue
signal move_orange_cat
signal stop_moving
#signal has_pickedup_key(pickedup_key)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
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
	elif direction.x < 0:
		#face right
		get_node("AnimatedSprite2D").flip_h = true
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
		ball_instance.position.x = cat.position.x - 47
	else:
		ball_instance.position.x = cat.position.x + 50
	ball_instance.position.y = cat.position.y - 5
	
	if Global.yarn_room == "Room5":
		emit_signal("move_orange_cat")
	
	get_parent().get_node(Global.yarn_room + "/Yarn").connect("pickup_yarn", pickup_yarn)

func pickup_wood():
	collect(wood)
	Global.wood_inv = true

func pickup_code(code_num):
	if code_num == 2:
		collect(code_digit2)
		Global.code2_inv = true
	elif code_num == 4:
		collect(code_digit4)
		Global.code4_inv = true
	elif code_num == 6:
		collect(code_digit6)
		Global.code6_inv = true
	elif code_num == 9:
		collect(code_digit9)
		Global.code9_inv = true

func pickup_key(key_num):
	if key_num == 1:
		collect(door_key)
		Global.door_key_inv = true
		open_pickup_key_dialogue()
	elif key_num == 2:
		collect(door2_key)
		Global.door2_key_inv = true
		
func pickup_piece(piece_num):
	if piece_num == 1:
		collect(puzzle_piece1)
		Global.puzzle_piece1_inv = true
	elif piece_num == 2:
		collect(puzzle_piece2)
		Global.puzzle_piece2_inv = true
	elif piece_num == 3:
		collect(puzzle_piece3)
		Global.puzzle_piece3_inv = true
	elif piece_num == 4:
		collect(puzzle_piece4)
		Global.puzzle_piece4_inv = true
	
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
	
func place_piece(piece_num):
	if piece_num == 1:
		use(puzzle_piece1)
		Global.puzzle_piece1_inv = false
		Global.puzzle_piece1_placed = true
	elif piece_num == 2:
		use(puzzle_piece2)
		Global.puzzle_piece2_inv = false
		Global.puzzle_piece2_placed = true
	elif piece_num == 3:
		use(puzzle_piece3)
		Global.puzzle_piece3_inv = false
		Global.puzzle_piece3_placed = true
	elif piece_num == 4:
		use(puzzle_piece4)
		Global.puzzle_piece4_inv = false
		Global.puzzle_piece4_placed = true
		
func use_wood():
	use(wood)
	Global.wood_inv = false
	Global.wood_placed = true

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

func open_count_chest():
	pass
	
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

func yarn_room(yarn_path) -> void:
	get_parent().get_node(yarn_path).connect("pickup_yarn", pickup_yarn)

func room0_objects() -> void:
	get_parent().get_node("Room0/Door2_Key").connect("pickup_key", pickup_key)

func room1_objects() -> void:
	get_parent().get_node("Room1/Door_Key").connect("pickup_key", pickup_key)

func room2_objects() -> void:
	get_parent().get_node("Room2/Door").connect("use_door_key", use_door_key)
	get_parent().get_node("Room2/Code_Digit4").connect("pickup_code", pickup_code)

func room3_objects() -> void:
	get_parent().get_node("Room3/KeyChest").connect("open_key_chest", open_key_chest)
	
func room4_objects() -> void:
	get_parent().get_node("Room4/Claw").connect("pickup_claw", pickup_claw)
	get_parent().get_node("Room4/Code_Digit2").connect("pickup_code", pickup_code)
	get_parent().get_node("Room4/Code_Digit6").connect("pickup_code", pickup_code)
	get_parent().get_node("Room4/Puzzle_Piece1").connect("pickup_piece", pickup_piece)

func room5_objects() -> void:
	get_parent().get_node("Room5").connect("use_axe", use_axe)
	get_parent().get_node("Room5").connect("pickup_wood", pickup_wood)
	get_parent().get_node("Room5/NumberCodeChest/Number_Code_UI").connect("open_number_chest", open_number_chest)
	get_parent().get_node("Room5/Code_Digit9").connect("pickup_code", pickup_code)

func room6_objects() -> void:
	get_parent().get_node("Room6/Puzzle_Piece2").connect("pickup_piece", pickup_piece)
	get_parent().get_node("Room6").connect("use_wood", use_wood)

func room7_objects() -> void:
	get_parent().get_node("Room7/CountCodeChest").connect("open_count_chest", open_count_chest)
	get_parent().get_node("Room7/Puzzle_Piece3").connect("pickup_piece", pickup_piece)
	
func room8_objects() -> void:
	get_parent().get_node("Room8/PlacedPieces").connect("place_piece", place_piece)
	
