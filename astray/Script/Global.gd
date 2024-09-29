extends Node

var door_open = false
var door2_open = false
var door_key_inv = false
var door2_key_inv = false
var used_door_key = false
var used_door2_key = false

var chest_key_inv = false
var used_chest_key = false

var yarn_inv = false
var yarn_room = "Room2"
var yarn_posx = 557
var yarn_posy = 56

var claw_inv = false

var axe_inv = false
var axe_used = false
var tree_down = false
var wood_inv = false
var wood_placed = false

var code2_inv = false
var code4_inv = false
var code6_inv = false
var code9_inv = false

var puzzle_piece1_inv = false
var puzzle_piece2_inv = false
var puzzle_piece3_inv = false
var puzzle_piece4_inv = false
var puzzle_piece1_placed = false
var puzzle_piece2_placed = false
var puzzle_piece3_placed = false
var puzzle_piece4_placed = false

var room

var ash_pos = Vector2(1125, 147)

var random_key: int

# Predefined list of keys (add more as needed)
var key_list = [
	KEY_0, KEY_1, KEY_2, KEY_3,
	KEY_4, KEY_5, KEY_6, KEY_7,
	KEY_8, KEY_9,
	KEY_B, KEY_C, KEY_F, KEY_G, 
	KEY_H, KEY_I, KEY_J, KEY_K, 
	KEY_L, KEY_M, KEY_N, KEY_O,
	KEY_P, KEY_Q, KEY_R, KEY_T,
	KEY_U, KEY_V, KEY_X, KEY_Y,
	KEY_Z,
	KEY_SHIFT, KEY_CTRL, KEY_SPACE,
	KEY_ENTER, KEY_BACKSPACE
]


func _ready() -> void:
	random_key = key_list[randi() % key_list.size()]
	
	var key_event = InputEventKey.new()
	key_event.physical_keycode = random_key
	InputMap.add_action("random_key")
	InputMap.action_add_event("random_key", key_event)

	print("Press this key to enable can_enter:", get_key_name(random_key))
	
func get_key_name(key_code: int) -> String:
	match key_code:
		KEY_0: return "0"
		KEY_1: return "1"
		KEY_2: return "2"
		KEY_3: return "3"
		KEY_4: return "4"
		KEY_5: return "5"
		KEY_6: return "6"
		KEY_7: return "7"
		KEY_8: return "8"
		KEY_9: return "9"
		KEY_B: return "B"
		KEY_C: return "C"
		KEY_F: return "F"
		KEY_G: return "G"
		KEY_H: return "H"
		KEY_I: return "I"
		KEY_J: return "J"
		KEY_K: return "K"
		KEY_L: return "L"
		KEY_M: return "M"
		KEY_N: return "N"
		KEY_O: return "O"
		KEY_P: return "P"
		KEY_Q: return "Q"
		KEY_R: return "R"
		KEY_T: return "T"
		KEY_U: return "U"
		KEY_V: return "V"
		KEY_X: return "X"
		KEY_Y: return "Y"
		KEY_Z: return "Z"
		KEY_SHIFT: return "Shift"
		KEY_CTRL: return "Control"
		KEY_SPACE: return "Space"
		KEY_ENTER: return "Enter"
		KEY_BACKSPACE: return "Backspace"
		_ : return str(key_code)  # Return the integer if not matched
