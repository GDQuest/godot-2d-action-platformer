extends PlayerState

onready var _dash_timer: Timer = $DashTime
onready var _dash_cooldown: Timer = $DashCoolDown


func _enter(_msg: Dictionary = {}) -> void:
	if _dash_cooldown.is_stopped():
		_dash_cooldown.start()
		player.gravity_multipler = 0.0
		player.velocity = player.aim_direction * player.DASH_SPEED
		_dash_timer.start()

		player.aim_direction = player.calculate_input_direction()
	else:
		_next_state()


#TODO: should dash stop prematurely?
func _update(delta: float) -> void:
	if Input.is_action_just_released("dash"):
		_next_state()


func _exit() -> void:
	player.gravity_multipler = 1.0


func _next_state():
	if player.is_on_floor():
		_state_machine.transition_to("Idle")
	else:
		_state_machine.transition_to("Fall")


func _on_DashTime_timeout() -> void:
	player.velocity /= 5.0
	_next_state()
