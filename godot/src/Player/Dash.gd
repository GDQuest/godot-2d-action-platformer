extends State

onready var _dash_time = $DashTime
onready var _dash_cooldown = $DashCoolDown


func _enter(_msg: Dictionary = {}) -> void:
	if _dash_cooldown.is_stopped():
		_dash_cooldown.start()
		owner.gravity_modifier = 0.0
		owner.velocity = owner.aim_direction * owner.DASH_SPEED
		_dash_time.start()
		
			# Calculate aim direction according to movement inputs
			
		var vertical_aim := Input.get_action_strength("Down") - Input.get_action_strength("Up")
		var horizontal_aim : float = Input.get_action_strength("Right") - Input.get_action_strength("Left")

		owner.aim_direction = Vector2(horizontal_aim, vertical_aim).normalized()

		if owner.aim_direction == Vector2.ZERO:
			owner.aim_direction = Vector2.RIGHT*owner.facing_direction
			
	else:
		next_state()


func _update(delta : float) -> void:
	if Input.is_action_just_released("dash"):
		next_state()


func _exit() -> void:
	owner.gravity_modifier = 1.0


func _on_DashTime_timeout() -> void:
	owner.velocity /= 5.0
	next_state()


func next_state():
	if owner.is_on_floor():
		_state_machine.transition_to("Idle")
	else:
		_state_machine.transition_to("Fall")
