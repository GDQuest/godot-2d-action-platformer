extends State


func _enter(_msg: Dictionary = {}) -> void:
	owner.velocity.y = owner.JUMP_SPEED


func _update(delta : float) -> void:
	if owner.velocity.y >= 0:
		_transition_to("Fall")
	
	var target_speed = owner.speed * (Input.get_action_strength("Right") -
		Input.get_action_strength("Left"))
	
	owner.velocity.x = lerp(owner.velocity.x, target_speed, 0.1)
	
	if owner.is_on_wall():
		_transition_to("OnWall")
	
	if Input.is_action_just_released("Jump"):
		owner.velocity.y /= 3.0
	
	if Input.is_action_just_pressed("Dash"):
			_transition_to("Dash")
