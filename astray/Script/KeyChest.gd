extends StaticBody2D

var chest_opened = false
var on_chest

signal open_key_chest

@onready var audio_player = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.frame = 0
	if Global.axe_inv or Global.axe_used:
		chest_opened = true
		$AnimatedSprite2D.frame = 3
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_chest and Input.is_action_pressed("Interact") and Global.chest_key_inv:
		emit_signal("open_key_chest")
		audio_player.play()
		$AnimatedSprite2D.play("OpenChest")

func _on_hitbox_area_entered(area: Area2D) -> void:
	on_chest = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	on_chest = false
	audio_player.stop()
