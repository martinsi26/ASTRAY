extends RigidBody2D

var on_yarn = false

signal pickup_yarn

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Global.yarn_inv:
		queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if on_yarn and Input.is_action_just_pressed("Interact"):
		pickup()

func pickup():
	emit_signal("pickup_yarn")
	queue_free()
	
func _on_hitbox_area_entered(area: Area2D) -> void:
	on_yarn = true

func _on_hitbox_area_exited(area: Area2D) -> void:
	on_yarn = false
