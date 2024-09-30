extends StaticBody2D

@onready var audio_player = $AudioStreamPlayer2D

var on_chest = false
var chest_open = false

signal open_count_code
signal close_count_code

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.frame = 0
	if Global.puzzle_piece4_inv or Global.puzzle_piece4_placed:
		chest_open = true
		$AnimatedSprite2D.frame = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_chest and Input.is_action_pressed("Interact") and !chest_open:
		emit_signal("open_count_code")

func _on_hitbox_area_entered(area: Area2D) -> void:
	on_chest = true
	
func _on_hitbox_area_exited(area: Area2D) -> void:
	on_chest = false
	audio_player.stop()
	emit_signal("close_count_code")

func open_chest() -> void:
	$AnimatedSprite2D.play("OpenChest")
	if audio_player:
		audio_player.play()
	else:
		print("No aduioo")
		pass
		
