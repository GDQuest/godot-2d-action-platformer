extends PlayerState


func _enter(_msg: Dictionary = {}) -> void:
	player.velocity.y = player.JUMP_SPEED


func _update(delta: float) -> void:
	if player.velocity.y >= 0:
		_state_machine.transition_to("Fall")

	var target_speed = (
		player.speed
		* (Input.get_action_strength("right") - Input.get_action_strength("left"))
	)

	player.velocity.x = lerp(player.velocity.x, target_speed, 6 * delta)

	player.aim_direction = player.calculate_input_direction()

	if player.is_on_wall():
		_state_machine.transition_to("OnWall")

	if Input.is_action_just_released("jump"):
		player.velocity.y /= 3.0

	if Input.is_action_just_pressed("dash"):
		_state_machine.transition_to("Dash")
