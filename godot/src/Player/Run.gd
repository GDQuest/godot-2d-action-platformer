extends State


func _update(delta : float) -> void:
	if owner.is_on_floor():
		owner.velocity.x = owner.speed * (Input.get_action_strength("right") -
		Input.get_action_strength("left"))
		
		if is_equal_approx(owner.velocity.x, 0.0):
			_state_machine.transition_to("Idle") 
		
		if Input.is_action_just_pressed( "jump" ):
			_state_machine.transition_to("Jump")
			
		if Input.is_action_just_pressed("dash"):
			_state_machine.transition_to("Dash")
			
		# Calculate aim direction according to movement inputs
			
		var vertical_aim := Input.get_action_strength("down") - Input.get_action_strength("up")
		var horizontal_aim : float = Input.get_action_strength("right") - Input.get_action_strength("left")

		owner.aim_direction = Vector2(horizontal_aim, vertical_aim).normalized()

		if owner.aim_direction == Vector2.ZERO:
			owner.aim_direction = Vector2.RIGHT*owner.facing_direction

	else:
		_state_machine.transition_to("Fall", {"ledge_forgive" : true})
