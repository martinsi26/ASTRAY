extends CharacterBody2D

const speed = 200
var move = false
var animation_played = false

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$".".position = Global.ash_pos
	get_parent().get_parent().get_node("Cat").connect("move_ash", move_ash)
	get_parent().get_parent().get_node("Cat").connect("stop_moving", move_back)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if move:
		var next_path_pos := nav_agent.get_next_path_position()
		var direction = global_position.direction_to(next_path_pos)
		
		if direction.x != 0 or direction.y != 0:
			$AnimatedSprite2D.play("Walk")
		if direction.x > 0:
			#face left
			get_node("AnimatedSprite2D").flip_h = false
			$HitboxRight.disabled = false
			$HitboxLeft.disabled = true
		elif direction.x < 0:
			#face right
			get_node("AnimatedSprite2D").flip_h = true
			$HitboxRight.disabled = true
			$HitboxLeft.disabled = false
			
		velocity = direction * speed
	else:
		velocity = Vector2.ZERO
		get_node("AnimatedSprite2D").flip_h = true
		if !animation_played:
			$AnimatedSprite2D.play("Sit")
			animation_played = true
		
	move_and_slide()
	
func make_path(location):
	nav_agent.target_position = location.position

func move_ash():
	$Timer.start()
	move = true
	var yarn = get_parent().get_node("Yarn")
	make_path(yarn)

func move_back():
	$Timer.stop()
	move = true
	var back_pos = get_parent().get_node("BackPos")
	Global.ash_pos = back_pos.position
	make_path(back_pos)
	
func _on_navigation_agent_2d_target_reached() -> void:
	$Timer.stop()
	move = false
	Global.ash_pos = $".".position
	animation_played = false

func _on_timer_timeout() -> void:
	move_ash()