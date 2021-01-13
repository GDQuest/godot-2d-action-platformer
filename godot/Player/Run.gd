extends PlayerState


func _update(_delta: float) -> void:
	if not player.is_on_floor():
		_state_machine.transition_to("Fall", {"ledge_forgive": true})
		return

	player.velocity.x = player.speed * player.movement_direction.x

	if is_equal_approx(player.velocity.x, 0.0):
		_state_machine.transition_to("Idle")
	elif Input.is_action_just_pressed("dash"):
		_state_machine.transition_to("Dash")
	elif Input.is_action_just_pressed("jump"):
		_state_machine.transition_to("Jump")
