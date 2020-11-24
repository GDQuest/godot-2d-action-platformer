extends PlayerState

onready var _input_buffer: Timer = $InputBufferingTimer
onready var _ledge_forgive: Timer = $LedgeForgivenessTimer


func _enter(_msg: Dictionary = {}) -> void:
	if "ledge_forgive" in _msg:
		_ledge_forgive.start()


func _exit() -> void:
	_ledge_forgive.stop()


func _update(delta: float) -> void:
	player.aim_direction = player.calculate_input_direction()
	var target_speed: float = player.speed * player.aim_direction.x

	player.velocity.x = lerp(player.velocity.x, target_speed, 6 * delta)

	if player.is_on_floor():
		if not _input_buffer.is_stopped():
			_state_machine.transition_to("Jump")
		else:
			_state_machine.transition_to("Idle")

	if Input.is_action_just_pressed("jump"):
		if not _ledge_forgive.is_stopped():
			_state_machine.transition_to("Jump")
		else:
			_input_buffer.start()

	if player.is_on_wall():
		_state_machine.transition_to("OnWall")

	if Input.is_action_just_pressed("dash"):
		_state_machine.transition_to("Dash")
