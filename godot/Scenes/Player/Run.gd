extends State


func _update(delta : float) -> void:
	if owner.is_on_floor():
		owner.velocity.x = owner.speed * (Input.get_action_strength("Right") -
		Input.get_action_strength("Left"))
		
		if is_equal_approx(owner.velocity.x, 0.0):
			_state_machine.transition_to("Idle") 
		
		if Input.is_action_just_pressed( "Jump" ):
			_state_machine.transition_to("Jump")
			
		if Input.is_action_just_pressed("Dash"):
			_state_machine.transition_to("Dash")
			
		# Calculate aim direction according to movement inputs
			
		var vertical_aim := Input.get_action_strength("Down") - Input.get_action_strength("Up")
		var horizontal_aim : float = Input.get_action_strength("Right") - Input.get_action_strength("Left")

		owner.aim_direction = Vector2(horizontal_aim, vertical_aim).normalized()

		if owner.aim_direction == Vector2.ZERO:
			owner.aim_direction = Vector2.RIGHT*owner.facing_direction

	else:
		_state_machine.transition_to("Fall", {"ledge_forgive" : true})
