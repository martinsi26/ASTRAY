extends Node2D

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
var room11 = preload("res://Rooms/RoomScene/Room11.tscn")

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
var instance11 = room11.instantiate()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#add_child(instance1)
	#$Cat.position = instance1.get_node("R1Spawn").position
	#instance1.connect("enter_room2", enter_room2)
	
	add_child(instance6)
	$Cat.position = instance6.get_node("FromR5").position
	instance6.connect("enter_room5", enter_room5)
	instance6.connect("enter_room7", enter_room7)
	instance6.connect("enter_room8", enter_room8)

func enter_room0(room_number):
	pass
	
func enter_room1(room_number):
	pass
	
func enter_room2(room_number):
	pass
	
func enter_room3(room_number):
	pass
	
func enter_room4(room_number):
	pass
	
func enter_room5(room_number):
	if room_number == 6:
		instance6.queue_free()
		instance6 = room6.instantiate()
		add_child(instance5)
		$Cat.position = instance5.get_node("FromR6").position
		instance5.connect("enter_room6", enter_room6)
	
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
	instance6.connect("enter_room5", enter_room5)
	instance6.connect("enter_room7", enter_room7)
	instance6.connect("enter_room8", enter_room8)
	
func enter_room7(room_number):
	if room_number == 6:
		instance6.queue_free()
		instance6 = room6.instantiate()
		add_child(instance7)
		$Cat.position = instance7.get_node("FromR6").position
		instance7.connect("enter_room6", enter_room6)

func enter_room8(room_number):
	if room_number == 6:
		instance6.queue_free()
		instance6 = room6.instantiate()
		add_child(instance8)
		$Cat.position = instance8.get_node("FromR6").position
		instance8.connect("enter_room6", enter_room6)
	
func enter_room9(room_number):
	pass

func enter_room10(room_number):
	pass
	
func enter_room11(room_number):
	pass
	
#
#func _on_cat_enter_room_1() -> void:
	#instance2.queue_free()
	#instance2 = room2.instantiate()
	#add_child(instance1)
	#$Cat.position = instance1.get_node("R1ReturnRight").position
#
#func _on_cat_enter_room_2() -> void:
	#instance1.queue_free()
	#instance1 = room1.instantiate()
	#add_child(instance2)
	#$Cat.position = instance2.get_node("R2Spawn").position
#
