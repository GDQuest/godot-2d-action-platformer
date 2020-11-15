extends State


func _update(delta : float) -> void:
	owner.velocity.x = 0
	if owner.is_on_floor():
		if Input.is_action_pressed("Left") or \
			Input.is_action_pressed("Right"):
				_state_machine.transition_to("Run")
		
		if Input.is_action_just_pressed("Jump"):
			_state_machine.transition_to("Jump")
			
		if Input.is_action_just_pressed("Dash"):
			_state_machine.transition_to("Dash")
		# Calculate aim direction according to movement inputs
			
		owner.aim_direction.y = Input.get_action_strength("Down") - Input.get_action_strength("Up")
		owner.aim_direction.x = Input.get_action_strength("Right") - Input.get_action_strength("Left")
		
		owner.aim_direction = owner.aim_direction.normalized()
		
		if owner.aim_direction == Vector2.ZERO:
			owner.aim_direction = Vector2.RIGHT*owner.facing_direction
		
	else:
		_state_machine.transition_to("Fall", {"ledge_forgive" : true})

