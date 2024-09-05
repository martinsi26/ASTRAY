extends CharacterBody2D

var dialogue = preload("res://Scene/Dialogue.tscn")
var speed = 500

@export var inv: Inv
@export var key: InvItem
@export var puzzle_piece1: InvItem

var push_force = 40

var collected_key = false
var found_key = false
var on_key = false
var on_chest = false
var key_used = false

var current_dialogue
var found_key_dialogue
var found_chest_dialogue
var open_chest_dialgoue

signal enter_room1
signal enter_room2

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
	
	if Input.is_action_pressed("Interact"):
		if on_key == true:
			pick_up()
		elif on_chest == true and key_used == false and collected_key == true:
			key_used = true
			open_chest()
		
	velocity = direction * speed
	move_and_slide()
	
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)
		
func pick_up():
	collect(key)
	collected_key = true
	get_parent().get_node("Room1/Key").visible = false
	get_parent().get_node("Room1/Key").set_collision_layer(0)
	get_parent().get_node("Room1/Key").set_collision_mask(0)

func open_chest():
	if current_dialogue != null:
			current_dialogue.queue_free()
	use(key)
	open_chest_dialgoue = dialogue.instantiate()
	open_chest_dialgoue.messages = [
		"The Chest Is Open!",
		"You Got An Item!"
	]
	get_parent().get_node("Room2/Chest").add_child(open_chest_dialgoue)
	current_dialogue = open_chest_dialgoue
	# open chest animation plays
	# give the player an item
	collect(puzzle_piece1)
	
func show_key():
	if found_key == false:
		get_parent().get_node("Room1/Key").visible = true
		
		if current_dialogue != null:
			current_dialogue.queue_free()
		found_key_dialogue = dialogue.instantiate()
		found_key_dialogue.messages = [
			"You Have Found A Key!", 
			"Press 'E' To Pick It Up"
		]
		get_parent().get_node("Room1/Key").add_child(found_key_dialogue)
		current_dialogue = found_key_dialogue
		found_key = true

func chest_dialogue():
	if current_dialogue != null:
			current_dialogue.queue_free()
	found_chest_dialogue = dialogue.instantiate()
	found_chest_dialogue.messages = [
		"You Found A Chest!",
		"Press 'E' With The Key"
	]
	get_parent().get_node("Room2/Chest").add_child(found_chest_dialogue)
	current_dialogue = found_chest_dialogue
	
func _on_area_2d_body_entered(body):
	if body.name == "Key":
		on_key = true
		show_key()
	elif body.name == "Path1":
		if collected_key == false: # if the cat has left the room but never picked up the key,
			found_key = false  # make sure the key is still not considered found
		emit_signal("enter_room2")
		#get_tree().change_scene_to_file("res://Room2.tscn")
	elif body.name == "Path1Back":
		emit_signal("enter_room1")
	elif body.name == "Chest":
		on_chest = true
		if key_used == false:
			chest_dialogue()


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Key":
		on_key = false
	elif body.name == "Chest":
		on_chest = false
		
func collect(item):
	inv.insert(item)

func use(item):
	inv.remove(item)
