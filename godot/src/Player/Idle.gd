extends PlayerState


func _enter(_msg := {}) -> void:
	player.velocity.x = 0


func _update(_delta: float) -> void:
	if not player.is_on_floor():
		_state_machine.transition_to("Fall", {"ledge_forgive": true})
		return

	if Input.is_action_just_pressed("dash"):
		_state_machine.transition_to("Dash")
	elif Input.is_action_just_pressed("jump"):
		_state_machine.transition_to("Jump")
	elif Input.is_action_pressed("left") or Input.is_action_pressed("right"):
		_state_machine.transition_to("Run")

