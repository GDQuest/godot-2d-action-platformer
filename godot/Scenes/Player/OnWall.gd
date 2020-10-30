extends State

var forgiveness_time := 0.0
var wall_normal := Vector2.ZERO
var wall_friction := 0.3


func _enter(_msg: Dictionary = {}) -> void:
	forgiveness_time = 0.1
	wall_normal = owner.get_slide_collision(0).normal


func _update(delta : float) -> void:
	forgiveness_time -= delta
	owner.velocity.y -= owner.velocity.y * wall_friction
	owner.velocity.x = owner.speed * (Input.get_action_strength("Right") -
		Input.get_action_strength("Left"))
	
	if !owner.is_on_wall() and forgiveness_time <= 0:
		_transition_to("Fall", {"ledge_forgive" : true})
		return

	if Input.is_action_just_pressed("Jump"):
		owner.velocity = owner.JUMP_SPEED * wall_normal.rotated(45)
		owner.velocity.x *= -1
		_transition_to("Jump")
		
	if Input.is_action_just_pressed("Dash"):
			_transition_to("Dash")
