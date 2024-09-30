extends Node2D

var answer_box = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Answer_Box.visible = false
	$ColorRect.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_option_button_pressed() -> void:
	if !answer_box:
		$Answer_Box.visible = true
		$ColorRect.visible = true
		answer_box = true
	else:
		$Answer_Box.visible = false
		$ColorRect.visible = false
		answer_box = false
		

func _on_option_button_item_selected(index: int) -> void:
	if index == 0:
		$Answer_Box.text = "Key for 1st door is hidden in a bush somewhere in the first room"
	elif index == 1:
		$Answer_Box.text = "Use the claw to collect items in the trees"
	elif index == 2:
		$Answer_Box.text = "Distract him from the doorway with a toy (yarn) by dropping it!"
	elif index == 3:
		$Answer_Box.text = "These numbers colors look vaguely familiar... (ANSWER: 6924)"
	elif index == 4:
		$Answer_Box.text = "Open using the key from the color numbers chest"
	elif index == 5:
		$Answer_Box.text = "Use this axe to cut down the different (pine) tree then use the wood to make a bridge over the river in the next room."
	elif index == 6:
		$Answer_Box.text = "I wonder how many fruit there are in the room... (ANSWER: 9462)"
	elif index == 7:
		$Answer_Box.text = "Build the puzzle over the circle outline, there should be 4 puzzle pieces in all"
	elif index == 8:
		$Answer_Box.text = "Hold down the key told from the riddle in the last room " + "'" + Global.get_key_name(Global.random_key) + "'" + " while moving left in first room where you spawned"
	elif index == 9:
		$Answer_Box.text = "Open 2nd door with key from room 0"
	elif index == 10:
		$Answer_Box.visible = false
		$ColorRect.visible = false
	answer_box = false
