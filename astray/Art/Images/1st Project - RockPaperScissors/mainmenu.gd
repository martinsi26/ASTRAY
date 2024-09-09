extends Control

@onready var button_SFX = $button_SFX

# Called when the node enters the scene tree for the first time.
#func _ready():
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

func _on_start_pressed():
	button_SFX.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://showdown.tscn")

func _on_quit_pressed():
	button_SFX.play()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
