extends State


func _update(delta: float) -> void:
	owner.velocity.x = 0
	if owner.is_on_floor():
		if Input.is_action_pressed("left") or Input.is_action_pressed("right"):
			_state_machine.transition_to("Run")

		if Input.is_action_just_pressed("jump"):
			_state_machine.transition_to("Jump")

		if Input.is_action_just_pressed("dash"):
			_state_machine.transition_to("Dash")
		# Calculate aim direction according to movement inputs

		owner.aim_direction.y = Input.get_action_strength("down") - Input.get_action_strength("up")
		owner.aim_direction.x = (
			Input.get_action_strength("right")
			- Input.get_action_strength("left")
		)

		owner.aim_direction = owner.aim_direction.normalized()

		if owner.aim_direction == Vector2.ZERO:
			owner.aim_direction = Vector2.RIGHT * owner.facing_direction

	else:
		_state_machine.transition_to("Fall", {"ledge_forgive": true})
