extends State

var direction := Vector2.ZERO

onready var _dash_time = $DashTime
onready var _dash_cooldown = $DashCoolDown


func _enter(_msg: Dictionary = {}) -> void:
	if _dash_cooldown.is_stopped():
		_dash_cooldown.start()
		owner.gravity_modifier = 0.0
		direction = owner.global_position.direction_to(get_global_mouse_position())
		owner.velocity = direction * owner.DASH_SPEED
		_dash_time.start()
	else:
		next_state()


func _exit() -> void:
	owner.gravity_modifier = 1.0


func _on_DashTime_timeout() -> void:
	owner.velocity /= 5.0
	next_state()


func next_state():
	if owner.is_on_floor():
		_transition_to("Idle")
	else:
		_transition_to("Fall")
