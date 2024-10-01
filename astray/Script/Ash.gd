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

var first_pickup_yarn
var first_touch_yarn

# signals
signal move_orange_cat
signal stop_moving
signal start_dialogue(dialogue)
#signal has_pickedup_key(pickedup_key)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	first_pickup_yarn = true
	first_touch_yarn = true
	
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
	
	if first_pickup_yarn:
		dialogue = [
			"Press 'E' on the yarn image in your inventory to drop it."
		]
		emit_signal("start_dialogue", dialogue)
		first_pickup_yarn = false
	
func pickup_claw():
	collect(claw)
	Global.claw_inv = true
	
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
	if (Global.puzzle_piece1_placed and Global.puzzle_piece2_placed 
		and Global.puzzle_piece3_placed and Global.puzzle_piece4_placed):
		dialogue = [
			"Fantastic the door is now open!"
		]
		emit_signal("start_dialogue", dialogue)
		
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
	Global.number_chest_open = true
	
	dialogue = [
		"Great, we found another key!",
		"Press 'TAB' to look at the key in your inventory."
	]
	emit_signal("start_dialogue", dialogue)

func open_count_chest():
	collect(puzzle_piece4)
	Global.puzzle_piece4_inv = true
	Global.count_chest_open = true
	
	dialogue = [
		"WOO-HOO, we found a puzzle piece!",
		"I feel like we're getting closer to my home!"
	]
	emit_signal("start_dialogue", dialogue)
	
func open_key_chest():
	use(chest_key)
	Global.used_chest_key = true
	Global.chest_key_inv = false
	Global.key_chest_open = true
	collect(axe)
	Global.axe_inv = true
	
	dialogue = [
		"Great, we found an axe!",
		"This could be useful.",
		"Press 'TAB' to check the axe is in your inventory."
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

var room1_play = true
func room1_objects() -> void:
	if room1_play:
		set_physics_process(false)
		dialogue = [
			"Oh no I am lost! What am I going to do?",
			"I bet my owner is worried sick. I better find my way home.",
			"Here are some basic controls:",
			"Press 'ESC' to pause the game.",
			"Use 'WASD' to move around.",
			"Press 'E' to interact with objects.",
			"Hold 'SHIFT' to run faster.",
			"If you forget any controls use the 'Help' button when paused",
			"Now have fun and get home!"
		]
		emit_signal("start_dialogue", dialogue)
		room1_play = false
		
		get_parent().get_node("Room1/Door_Key").connect("pickup_key", pickup_key)

func _on_timer_timeout() -> void:
	set_physics_process(true)
	
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

var room5_play = true
func room5_objects() -> void:
	if room5_play:
		dialogue = [
			"Oh no, it's the bad kitty, Ludacris!",
			"There has to be some way around him!",
			"I don't think we need to resort to fighting.",
			"Have you ever heard of the phrase Hakuna Matata?",
			"I base my life around it.", 
			"If you didn't know,",
			"it means no worries for the rest of your days!"
		]
		emit_signal("start_dialogue", dialogue)
		room5_play = false
	
	get_parent().get_node("Room5").connect("use_axe", use_axe)
	get_parent().get_node("Room5").connect("pickup_wood", pickup_wood)
	get_parent().get_node("Room5/NumberCodeChest/Number_Code_UI").connect("open_number_chest", open_number_chest)
	get_parent().get_node("Room5/Code_Digit9").connect("pickup_code", pickup_code)

func room6_objects() -> void:
	get_parent().get_node("Room6/Puzzle_Piece2").connect("pickup_piece", pickup_piece)
	get_parent().get_node("Room6").connect("use_wood", use_wood)

func room7_objects() -> void:
	get_parent().get_node("Room7/CountCodeChest/Count_Code_UI").connect("open_count_chest", open_count_chest)
	get_parent().get_node("Room7/Puzzle_Piece3").connect("pickup_piece", pickup_piece)
	
func room8_objects() -> void:
	get_parent().get_node("Room8/PlacedPieces").connect("place_piece", place_piece)
	
var room9_play = true
func room9_objects() -> void:
	if room9_play:
		dialogue = [
			"Look it's my home!",
			"I bet my owner will be so happy to see me again.",
			"Oooooh maybe there will be some food out for me!"
		]
		emit_signal("start_dialogue", dialogue)
		room9_play = false

var room10_play = true
func room10_objects() -> void:
	if room10_play:
		dialogue = [
			"There appears to be a riddle!",
			"A map on the ground shows where you've been",
			"At the start, a key you'll find within",
			"Press " + Global.get_key_name(Global.random_key) + " and hold in mind",
			"Only then the room's path will unwind",
			"Hmm I guess we need to solve this riddle!"
		]
		emit_signal("start_dialogue", dialogue)
		room10_play = false

var current_dialogue

func _on_hitbox_area_entered(area: Area2D) -> void:
	if area == get_parent().get_node("Room3/KeyChest/Hitbox"):
		if Global.key_chest_open:
			return
		else:
			dialogue = [
				"You have found a chest!",
				"I wonder if we found a pirate's hidden treasure,",
				"I'd be able to buy all the fish and treats in the world!",
				"Press 'E' with the key to open the chest."
			]
	elif area == get_parent().get_node("Room5/NumberCodeChest/Hitbox"):
		if Global.number_chest_open:
			return
		else:
			dialogue = [
				"Look at this huge chest!",
				"Press 'E' to look at the lock of the chest",
			]
	elif area == get_parent().get_node("Room7/CountCodeChest/Hitbox"):
		if Global.count_chest_open:
			return
		else:
			dialogue = [
				"Hmmm, I wonder how many days I've been lost in this forest?",
				"We should probably look at our surroundings."
			]
	elif area == get_parent().get_node("Room5/Cutting_Tree/Tree_Hitbox"):
		if Global.axe_inv:
			dialogue = [
				"Press 'E' to cut the tree with your axe!"
			]
		else:
			dialogue = [
				"This is an odd looking tree?"
			]
	elif area == get_parent().get_node("Room5/Wood/Wood_Hitbox"):
		if Global.tree_down:
			dialogue = [
				"Aha! We got some wood!",
				"This could prove to be useful.",
				"Press 'E' to pickup"
			]
	elif area == get_parent().get_node("Room1/Door_Key/Hitbox"):
		dialogue = [
			"You have found a key!",
			"What can it unlock?",
			"Press 'E' to pick up."
		]
	elif area == get_parent().get_node("Room0/Door2_Key/Hitbox"):
		dialogue = [
			"Nice, we got another key!",
			"I think it's time to get home!"
		]
	elif area == get_parent().get_node("Room5/OrangeCat/Hitbox"):
		if Global.orange_cat == Vector2(1125, 147):
			dialogue = [
				"Ludacris doesn't seem to want to move.",
				"Maybe we can find a way to get him out of our way."
			]
		else:
			return
	elif area == get_parent().get_node("Room4/Code_Digit6/Hitbox"):
		if Global.claw_inv:
			dialogue = [
				"Woah, there's a number card at the top of the tree!",
				"I wonder what we could use that for?",
				"Press 'E' to grab."
			]
		else:
			dialogue = [
				"The code seems too high up in the tree to grab,",
				"we should find something that can reach that height."
			]
	elif area ==  get_parent().get_node("Room2/Code_Digit4/Hitbox"):
		if Global.claw_inv:
			dialogue = [
				"Cool! You've found another number."
				]
		else:
			dialogue = [
				"The code seems too high up in the tree to grab,",
				"we should find something that can reach that height."
			]
	elif area ==  get_parent().get_node("Room4/Code_Digit2/Hitbox"):
		if Global.claw_inv:
			dialogue = [
				"You've found another number!", 
			]
		else:
			dialogue = [
				"The code seems too high up in the tree to grab,",
				"we should find something that can reach that height."
			]
	elif area ==  get_parent().get_node("Room5/Code_Digit9/Hitbox"):
		if Global.claw_inv:
			dialogue = [
				"Great job friend, we found another number!",
				"Maybe I can use it to find out where you live hehehe."
			]
		else:
			dialogue = [
				"The code seems too high up in the tree to grab,",
				"we should find something that can reach that height."
			]
	elif area ==  get_parent().get_node("Room4/Claw/Hitbox"):
		dialogue = [
			"What's that? It looks like a claw!", 
			"The clawwwwww!",
			"I wonder what we can use it for?",
		]
	elif area ==  get_parent().get_node("Room4/Puzzle_Piece1/Hitbox"):
		if Global.claw_inv: 
			dialogue = [
			"That's great! You found the a puzzle piece."
		]
		else:
			dialogue = [
				"The puzzle seems too high up in the tree to grab,",
				"we should find something that can reach that height."
			]
	elif area ==  get_parent().get_node("Room6/Puzzle_Piece2/Hitbox"):
		if Global.claw_inv:
			dialogue = [
				"Oh look! There's another puzzle piece." 
			]
		else:
			dialogue = [
				"The puzzle seems too high up in the tree to grab,",
				"we should find something that can reach that height."
			]
	elif area ==  get_parent().get_node("Room7/Puzzle_Piece3/Hitbox"):
		if Global.claw_inv:
			dialogue = [
				"Hey, there's another piece! We're so close to figuring this out!"
			]
		else:
			dialogue = [
				"The puzzle seems too high up in the tree to grab,",
				"we should find something that can reach that height."
			]
	elif area ==  get_parent().get_node("Room0/MissingPoster"):
		dialogue = [
			"Press 'E' to pick up.",
			"Oh look, there's a piece of paper!",
			"I wonder what's in it?",
			"Could it be a map to get home or your deleted tweets online?",
			"Oh no! My owner is looking for me, it's my missing cat poster :("
		]
	elif area == get_parent().get_node("Room2/Yarn/Hitbox"):
		if first_touch_yarn:
			dialogue = [
				"I LOVE LOVE LOVE playing with yarn!",
				"Let's pick it up to use later."
			]
			first_touch_yarn = false
		else:
			return
	elif area == get_parent().get_node("Room2/Door/Hitbox"):
		if Global.door_key_inv:
			dialogue = [
				"We found the first door!",
				"Press 'E' to use the key to open it."
			]
		else:
			dialogue = [
				"We can't open this door without the key."
			]
	elif area == get_parent().get_node("Room8/Door2/Hitbox"):
		if Global.door2_key_inv:
			dialogue = [
				"We found the last door.",
				"We are so close to home!"
			]
		else:
			dialogue = [
				"We can't open this door without the key."
			]
	elif area == get_parent().get_node("Room6/Place_Wood_Hitbox"):
		if Global.wood_inv:
			dialogue = [
				"Press 'E' to place the materials!"
			]
		elif !Global.wood_placed:
			dialogue = [
				"Oh no! How'll we get across?",
				"We need to build something."
			]
	elif area == get_parent().get_node("Room8/PlacedPieces/Hitbox"):
		if (!Global.puzzle_piece1_placed or !Global.puzzle_piece2_placed 
			or !Global.puzzle_piece3_placed or !Global.puzzle_piece4_placed):
			dialogue = [
				"Press 'E' to place the puzzle pieces!"
			]
		else:
			return
	elif area == get_parent().get_node("Room1/RiddleRepeat"):
		if (Global.puzzle_piece1_placed and Global.puzzle_piece2_placed 
			and Global.puzzle_piece3_placed and Global.puzzle_piece4_placed 
			and !Global.door2_key_inv):
			dialogue = [
				"This seems to be the place of the riddle.",
				"We must recall what the rest of the riddle says,",
				"Press " + Global.get_key_name(Global.random_key) + " and hold in mind",
				"Only then the room's path will unwind"
			]
		elif !Global.door2_key_inv:
			dialogue = [
				"It seem I can't go back there yet.",
				"I should come back later."
			]
		else:
			return
	else: 
		return
	if current_dialogue == dialogue:
		return
	current_dialogue = dialogue
	emit_signal("start_dialogue", dialogue)
