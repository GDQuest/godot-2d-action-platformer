extends State


func _enter(_msg: Dictionary = {}) -> void:
	owner.velocity.y = owner.JUMP_SPEED


func _update(delta : float) -> void:
	if owner.velocity.y >= 0:
		_state_machine.transition_to("Fall")
	
	var target_speed = owner.speed * (Input.get_action_strength("right") -
		Input.get_action_strength("left"))
	
	owner.velocity.x = lerp(owner.velocity.x, target_speed, 0.1)
	
	# Calculate aim direction according to movement inputs
			
	var vertical_aim := Input.get_action_strength("down") - Input.get_action_strength("up")
	var horizontal_aim : float = Input.get_action_strength("right") - Input.get_action_strength("left")

	owner.aim_direction = Vector2(horizontal_aim, vertical_aim).normalized()

	if owner.aim_direction == Vector2.ZERO:
		owner.aim_direction = Vector2.RIGHT*owner.facing_direction
	
	if owner.is_on_wall():
		_state_machine.transition_to("OnWall")
	
	if Input.is_action_just_released("jump"):
		owner.velocity.y /= 3.0
	
	if Input.is_action_just_pressed("dash"):
			_state_machine.transition_to("Dash")
