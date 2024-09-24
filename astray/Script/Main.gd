extends Node2D

var yarn_ball = preload("res://Scene/Yarn.tscn")

var room0 = preload("res://Rooms/RoomScene/Room0.tscn")
var room1 = preload("res://Rooms/RoomScene/Room1.tscn")
var room2 = preload("res://Rooms/RoomScene/Room2.tscn")
var room3 = preload("res://Rooms/RoomScene/Room3.tscn")
var room4 = preload("res://Rooms/RoomScene/Room4.tscn")
var room5 = preload("res://Rooms/RoomScene/Room5.tscn")
var room6 = preload("res://Rooms/RoomScene/Room6.tscn")
var room7 = preload("res://Rooms/RoomScene/Room7.tscn")
var room8 = preload("res://Rooms/RoomScene/Room8.tscn")
var room9 = preload("res://Rooms/RoomScene/Room9.tscn")
var room10 = preload("res://Rooms/RoomScene/Room10.tscn")

var instance0 = room0.instantiate()
var instance1 = room1.instantiate()
var instance2 = room2.instantiate()
var instance3 = room3.instantiate()
var instance4 = room4.instantiate()
var instance5 = room5.instantiate()
var instance6 = room6.instantiate()
var instance7 = room7.instantiate()
var instance8 = room8.instantiate()
var instance9 = room9.instantiate()
var instance10 = room10.instantiate()

signal door_key_room
signal door2_key_room
signal claw_room
signal key_chest_room
signal number_chest_room
signal door_room
signal tree_room
signal yarn_room

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Enter Room 1
	add_child(instance1)
	$Cat.position = instance1.get_node("Spawn").position
	instance1.connect("enter_room0", enter_room)
	instance1.connect("enter_room2", enter_room)
	emit_signal("door_key_room")
	
func enter_room(from_room, to_room):
	var from_room_path = "Room" + str(from_room)
	var to_room_path = "Room" + str(to_room)
	
	if from_room_path == Global.yarn_room and !Global.yarn_inv:
		Global.yarn_posx = get_node(from_room_path + "/Yarn").position.x
		Global.yarn_posy = get_node(from_room_path + "/Yarn").position.y
	if from_room == 0:
		if to_room == 1:
			enter_room1(from_room)
	elif from_room == 1:
		if to_room == 0:
			enter_room0(from_room)
		elif to_room == 2:
			enter_room2(from_room)
	elif from_room == 2:
		if to_room == 1:
			enter_room1(from_room)
		elif to_room == 3:
			enter_room3(from_room)
	elif from_room == 3:
		if to_room == 2:
			enter_room2(from_room)
		elif to_room == 4:
			enter_room4(from_room)
		elif to_room == 5:
			enter_room5(from_room)
	elif from_room == 4:
		enter_room3(from_room)
	elif from_room == 5:
		if to_room == 6:
			enter_room6(from_room)
		elif to_room == 3:
			enter_room3(from_room)
	elif from_room == 6:
		if to_room == 5:
			enter_room5(from_room)
		elif to_room == 7:
			enter_room7(from_room)
		elif to_room == 8:
			enter_room8(from_room)
	elif from_room == 7:
		enter_room6(from_room)
	elif from_room == 8:
		if to_room == 6:
			enter_room6(from_room)
		elif to_room == 9:
			enter_room9(from_room)
		elif to_room == 10:
			enter_room10(from_room)
	elif from_room == 9:
		if to_room == 8:
			enter_room8(from_room)
	elif from_room == 10:
		if to_room == 8:
			enter_room8(from_room)
			
	if to_room_path == Global.yarn_room and !Global.yarn_inv:
		var ball_instance = yarn_ball.instantiate()
		get_node(to_room_path).add_child(ball_instance)
		
		emit_signal("yarn_room", to_room_path + "/Yarn")
		
		get_node(to_room_path + "/Yarn").position.x = Global.yarn_posx
		get_node(to_room_path + "/Yarn").position.y = Global.yarn_posy
		
		
		
func enter_room0(room_number):
	if room_number == 1:
		instance1.queue_free()
		instance1 = room1.instantiate()
		add_child(instance0)
		$Cat.position = instance0.get_node("FromR1").position
	instance0.connect("enter_room1", enter_room)
	emit_signal("door2_key_room")
	Global.room = "Room0"
	
func enter_room1(room_number):
	if room_number == 0:
		instance0.queue_free()
		instance0 = room0.instantiate()
		add_child(instance1)
		$Cat.position = instance1.get_node("FromR0").position
	elif room_number == 2:
		instance2.queue_free()
		instance2 = room2.instantiate()
		add_child(instance1)
		$Cat.position = instance1.get_node("FromR2").position
	instance1.connect("enter_room0", enter_room)
	instance1.connect("enter_room2", enter_room)
	emit_signal("door_key_room")
	Global.room = "Room1"
	
func enter_room2(room_number):
	if room_number == 1:
		instance1.queue_free()
		instance1 = room1.instantiate()
		add_child(instance2)
		$Cat.position = instance2.get_node("FromR1").position
	elif room_number == 3:
		instance3.queue_free()
		instance3 = room3.instantiate()
		add_child(instance2)
		$Cat.position = instance2.get_node("FromR3").position
	instance2.connect("enter_room1", enter_room)
	instance2.connect("enter_room3", enter_room)
	emit_signal("door_room")
	Global.room = "Room2"
		
func enter_room3(room_number):
	if room_number == 2:
		instance2.queue_free()
		instance2 = room2.instantiate()
		add_child(instance3)
		$Cat.position = instance3.get_node("FromR2").position
	elif room_number == 4:
		instance4.queue_free()
		instance4 = room4.instantiate()
		add_child(instance3)
		$Cat.position = instance3.get_node("FromR4").position
	elif room_number == 5:
		instance5.queue_free()
		instance5 = room5.instantiate()
		add_child(instance3)
		$Cat.position = instance3.get_node("FromR5").position
	instance3.connect("enter_room2", enter_room)
	instance3.connect("enter_room4", enter_room)
	instance3.connect("enter_room5", enter_room)
	emit_signal("key_chest_room")
	Global.room = "Room3"
	
func enter_room4(room_number):
	if room_number == 3:
		instance3.queue_free()
		instance3 = room3.instantiate()
		add_child(instance4)
		$Cat.position = instance4.get_node("FromR3").position
	instance4.connect("enter_room3", enter_room)
	emit_signal("claw_room")
	Global.room = "Room4"
	
func enter_room5(room_number):
	if room_number == 6:
		instance6.queue_free()
		instance6 = room6.instantiate()
		add_child(instance5)
		$Cat.position = instance5.get_node("FromR6").position
	elif room_number == 3:
		instance3.queue_free()
		instance3 = room3.instantiate()
		add_child(instance5)
		$Cat.position = instance5.get_node("FromR3").position
	instance5.connect("enter_room6", enter_room)
	instance5.connect("enter_room3", enter_room)
	emit_signal("number_chest_room")
	Global.room = "Room5"
	
func enter_room6(room_number):
	if room_number == 7:
		instance7.queue_free()
		instance7 = room7.instantiate()
		add_child(instance6)
		$Cat.position = instance6.get_node("FromR7").position
	elif room_number == 5:
		instance5.queue_free()
		instance5 = room5.instantiate()
		add_child(instance6)
		$Cat.position = instance6.get_node("FromR5").position
	elif room_number == 8:
		instance8.queue_free()
		instance8 = room8.instantiate()
		add_child(instance6)
		$Cat.position = instance6.get_node("FromR8").position
	instance6.connect("enter_room5", enter_room)
	instance6.connect("enter_room7", enter_room)
	instance6.connect("enter_room8", enter_room)
	emit_signal("tree_room")
	Global.room = "Room6"
	
func enter_room7(room_number):
	if room_number == 6:
		instance6.queue_free()
		instance6 = room6.instantiate()
		add_child(instance7)
		$Cat.position = instance7.get_node("FromR6").position
	instance7.connect("enter_room6", enter_room)
	Global.room = "Room7"

func enter_room8(room_number):
	if room_number == 6:
		instance6.queue_free()
		instance6 = room6.instantiate()
		add_child(instance8)
		$Cat.position = instance8.get_node("FromR6").position
	elif room_number == 9:
		instance9.queue_free()
		instance9 = room9.instantiate()
		add_child(instance8)
		$Cat.position = instance8.get_node("FromR9").position
	elif room_number == 10:
		instance10.queue_free()
		instance10 = room10.instantiate()
		add_child(instance8)
		$Cat.position = instance8.get_node("FromR10").position
	instance8.connect("enter_room6", enter_room)
	instance8.connect("enter_room9", enter_room)
	instance8.connect("enter_room10", enter_room)
	Global.room = "Room8"
	
func enter_room9(room_number):
	if room_number == 8:
		instance8.queue_free()
		instance8 = room8.instantiate()
		add_child(instance9)
		$Cat.position = instance9.get_node("FromR8").position
	instance9.connect("enter_room8", enter_room)
	instance9.connect("ending", ending)
	Global.room = "Room9"

func enter_room10(room_number):
	if room_number == 8:
		instance8.queue_free()
		instance8 = room8.instantiate()
		add_child(instance10)
		$Cat.position = instance10.get_node("FromR8").position
	instance10.connect("enter_room8", enter_room)
	Global.room = "Room10"
	
func ending():
	get_tree().change_scene_to_file("res://Scene/EndingScreen.tscn")
