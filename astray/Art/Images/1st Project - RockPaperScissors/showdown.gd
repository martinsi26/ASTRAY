extends Node2D

@onready var turn = 1
@onready var p_points = 0
@onready var c_points = 0

@onready var button_SFX = $button_SFX
@onready var winRound_SFX = $Endscreen/winRound
@onready var looseRound_SFX = $Endscreen/looseRound
@onready var winGame_SFX = $Endscreen/winGame
@onready var looseGame_SFX = $Endscreen/looseGame

@onready var no_point1 = load("res://Score_Circles_1.png")
@onready var no_point2 = load("res://Score_Circles_2.png")
@onready var no_point3 = load("res://Score_Circles_3.png")
@onready var p_point1 = load("res://Score_Circles_1P.png")
@onready var p_point2 = load("res://Score_Circles_2P.png")
@onready var p_point3 = load("res://Score_Circles_3P.png")
@onready var c_point1 = load("res://Score_Circles_1C.png")
@onready var c_point2 = load("res://Score_Circles_2C.png")
@onready var c_point3 = load("res://Score_Circles_3C.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


# __Game Logic
func _reset_game():
	turn = 1
	p_points = 0
	c_points = 0
	
	$Scoreboard/point1.texture = no_point1
	$Scoreboard/point2.texture = no_point2
	$Scoreboard/point3.texture = no_point3
	
	$Endscreen.visible = false
	$Endscreen/Signs/WinScreen.visible = false
	$Endscreen/Signs/LooseScreen.visible = false

func _endscreen(winner):
	$Endscreen.visible = true
	
	if (winner == "p"):
		$Endscreen/Signs/WinScreen.visible = true
		winGame_SFX.play()
		
	elif (winner == "c"):
		$Endscreen/Signs/LooseScreen.visible = true
		looseGame_SFX.play()
	
func _reset_field():
	$player_Objects/p_Crown.visible = false
	$com_Objects/c_Crown.visible = false
	
	$player_Objects/p_ChoiceSprites/p_StoneSprite.visible = false
	$player_Objects/p_ChoiceSprites/p_PaperSprite.visible = false
	$player_Objects/p_ChoiceSprites/p_ScissorsSprite.visible = false
	$com_Objects/c_ChoiceSprites/c_StoneSprite.visible = false
	$com_Objects/c_ChoiceSprites/c_PaperSprite.visible = false
	$com_Objects/c_ChoiceSprites/c_ScissorsSprite.visible = false
	
	$player_Objects/p_StoneBtn.disabled = false
	$player_Objects/p_PaperBtn.disabled = false
	$player_Objects/p_ScissorsBtn.disabled = false

func _change_scoreboard(turn, winner):
	if (winner == "p"):
		p_points = p_points + 1
		$player_Objects/p_Crown.visible = true
	elif (winner == "c"):
		c_points = c_points + 1
		$com_Objects/c_Crown.visible = true
	
	await get_tree().create_timer(1).timeout
	
	if (turn == 1):
		if (winner == "p"):
			$Scoreboard/point1.texture = p_point1
		if (winner == "c"):
			$Scoreboard/point1.texture = c_point1
	if (turn == 2):
		if (winner == "p"):
			$Scoreboard/point2.texture = p_point2
		if (winner == "c"):
			$Scoreboard/point2.texture = c_point2
	if (turn == 3):
		if (winner == "p"):
			$Scoreboard/point3.texture = p_point3
		if (winner == "c"):
			$Scoreboard/point3.texture = c_point3
			
	if (p_points == 2):
		# print_debug("Player won!")
		_endscreen(winner)
	if (c_points == 2):
		# print_debug("COM won!")
		_endscreen(winner)


func _show_choices(pChoice, cChoice):
	if (pChoice == "Stone"):
		$player_Objects/p_ChoiceSprites/p_StoneSprite.visible = true
	elif (pChoice == "Paper"):
		$player_Objects/p_ChoiceSprites/p_PaperSprite.visible = true
	elif (pChoice == "Scissors"):
		$player_Objects/p_ChoiceSprites/p_ScissorsSprite.visible = true
		
	if (cChoice == "Stone"):
		$com_Objects/c_ChoiceSprites/c_StoneSprite.visible = true
	elif (cChoice == "Paper"):
		$com_Objects/c_ChoiceSprites/c_PaperSprite.visible = true
	elif (cChoice == "Scissors"):
		$com_Objects/c_ChoiceSprites/c_ScissorsSprite.visible = true


func _current_showdown_check(pChoice, cChoice):
	#print_debug("\n", pChoice, " vs ", cChoice)
	var winner = ""
	
	if pChoice == cChoice:
		#print_debug("Draw")
		winner = "d"
		
	if pChoice == "Stone":
		if cChoice == "Paper":
			looseRound_SFX.play()
			#print_debug("COM wins round ", turn)
			winner = "c"
		if cChoice == "Scissors":
			winRound_SFX.play()
			#print_debug("Player wins round ", turn)
			winner = "p"
	
	if pChoice == "Paper":
		if cChoice == "Stone":
			winRound_SFX.play()
			#print_debug("Player wins round ", turn)
			winner = "p"
		if cChoice == "Scissors":
			looseRound_SFX.play()
			#print_debug("COM wins round ", turn)
			winner = "c"
	
	if pChoice == "Scissors":
		if cChoice == "Stone":
			looseRound_SFX.play()
			#print_debug("COM wins round ", turn)
			winner = "c"
		if cChoice == "Paper":
			winRound_SFX.play()
			#print_debug("Player wins round ", turn)
			winner = "p"
	
	_show_choices(pChoice, cChoice)
	await get_tree().create_timer(0.5).timeout
	
	if (winner != "d"):
		_change_scoreboard(turn, winner)
		turn = turn + 1
	
	await get_tree().create_timer(2).timeout
	
	_reset_field()


func _com_turn(pChoice):
	var cNum = randi_range(0, 2)
	var cChoice = " "
	
	match cNum:
		0: cChoice = "Stone"
		1: cChoice = "Paper"
		2: cChoice = "Scissors"
	
	#print_debug("COM chose: ", cChoice)
	_current_showdown_check(pChoice, cChoice)


# __Player Input
func _on_return_button_pressed():
	button_SFX.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://mainmenu.tscn")


func _on_p_stone_btn_pressed():
	button_SFX.play()
	$player_Objects/p_StoneBtn.disabled = true
	$player_Objects/p_PaperBtn.disabled = true
	$player_Objects/p_ScissorsBtn.disabled = true
	var pChoice = "Stone"
	await get_tree().create_timer(0.5).timeout
	_com_turn(pChoice)


func _on_p_paper_btn_pressed():
	button_SFX.play()
	$player_Objects/p_StoneBtn.disabled = true
	$player_Objects/p_PaperBtn.disabled = true
	$player_Objects/p_ScissorsBtn.disabled = true
	var pChoice = "Paper"
	await get_tree().create_timer(0.5).timeout
	_com_turn(pChoice)


func _on_p_scissors_btn_pressed():
	button_SFX.play()
	$player_Objects/p_StoneBtn.disabled = true
	$player_Objects/p_PaperBtn.disabled = true
	$player_Objects/p_ScissorsBtn.disabled = true
	var pChoice = "Scissors"
	await get_tree().create_timer(0.5).timeout
	_com_turn(pChoice)


func _on_c_stone_btn_pressed():
	pass # Replace with function body.


func _on_c_paper_btn_pressed():
	pass # Replace with function body.


func _on_c_scissors_btn_pressed():
	pass # Replace with function body.


func _on_exit_pressed():
	button_SFX.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://mainmenu.tscn")


func _on_repeat_pressed():
	button_SFX.play()
	await get_tree().create_timer(0.5).timeout
	_reset_game()
