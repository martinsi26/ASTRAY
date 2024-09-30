extends Control

var inv = preload("res://Inventory/Player_inv.tres")

var is_visible = false

signal help_button

func _ready() -> void:
	$AnimationPlayer.play("RESET")

func resume():
	get_tree().paused = false
	if is_visible:
		get_parent().get_node("Ash/Inv_UI").visible = true
	$AnimationPlayer.play_backwards("blur")
	
func pause():
	if !get_parent().get_node("Ash/Inv_UI").visible:
		is_visible = false
	else:
		is_visible = true
		get_parent().get_node("Ash/Inv_UI").visible = false
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func testEsc():
	if Input.is_action_just_pressed("Pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Pause") and get_tree().paused:
		resume()

func _on_resume_pressed() -> void:
	resume()

func _on_help_pressed() -> void:
	$HelpScreen.visible = true
	emit_signal("help_button")

func _on_restart_pressed() -> void:
	resume()
	
	for items in inv.slots:
		items.item = null
			
	Global.reset()

	get_tree().reload_current_scene()

func _on_quit_menu_pressed() -> void:
	resume()
	get_tree().change_scene_to_file("res://Scene/Main.tscn")

func _on_quit_desktop_pressed() -> void:
	get_tree().quit()
	
func reset_global():
	# Remove the current instance of Global
	var global_node = get_tree().root.get_node("Global")
	if global_node:
		global_node.queue_free()  # This will delete the current Global instance

	# Create a new instance of Global and add it back to the root
	var new_global = preload("res://Script/Global.gd").new()
	get_tree().root.add_child(new_global)
	get_tree().root.set_meta("Global", new_global)  # Re-register it as the global singleton

	# You might also need to set it back as a singleton for easy access in scripts:
	set_script(new_global)
	
func _process(delta):
	testEsc()




