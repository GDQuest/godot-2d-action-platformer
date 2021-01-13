extends PlayerState

onready var _dash_timer: Timer = $DashTime


func _enter(_msg: Dictionary = {}) -> void:
	player.can_dash = false
	player.gravity_multipler = 0.0
	player.velocity = player.aim_direction * player.dash_speed
	if is_equal_approx(player.velocity.length(), 0.0):
		player.velocity.x = player.facing_direction * player.dash_speed
	_dash_timer.start()


func _update(_delta: float) -> void:
	if player.is_on_wall():
		_state_machine.transition_to("OnWall")


func _exit() -> void:
	_dash_timer.stop()
	player.gravity_multipler = 1.0


func _go_to_next_state():
	if player.is_on_floor():
		_state_machine.transition_to("Idle")
	elif player.is_on_wall():
		_state_machine.transition_to("OnWall")
	else:
		_state_machine.transition_to("Fall")


func _on_DashTime_timeout() -> void:
	player.velocity /= 5.0
	_go_to_next_state()
