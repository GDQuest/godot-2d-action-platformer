extends State

onready var _input_buffer := $InputBufferingTimer
onready var _ledge_forgive := $LedgeForgivenessTimer


func _enter(_msg: Dictionary = {}) -> void:
	_ledge_forgive.stop()
	if "ledge_forgive" in _msg:
		if _msg.ledge_forgive: 
			_ledge_forgive.start() 


func _update(delta : float) -> void:
	var target_speed = owner.speed * (Input.get_action_strength("right") -
		Input.get_action_strength("left"))
		
	owner.velocity.x = lerp(owner.velocity.x, target_speed, 6*delta)
	# Calculate aim direction according to movement inputs
			
	var vertical_aim := Input.get_action_strength("down") - Input.get_action_strength("up")
	var horizontal_aim : float = Input.get_action_strength("right") - Input.get_action_strength("left")

	owner.aim_direction = Vector2(horizontal_aim, vertical_aim).normalized()

	if owner.aim_direction == Vector2.ZERO:
		owner.aim_direction = Vector2.RIGHT*owner.facing_direction
		
	if owner.is_on_floor():
		if !_input_buffer.is_stopped():
			_state_machine.transition_to("Jump")
		else:
			_state_machine.transition_to("Idle")
		
	if Input.is_action_just_pressed("jump"):
		if !_ledge_forgive.is_stopped():
			_state_machine.transition_to("Jump")
		else:
			_input_buffer.start()
			
	if owner.is_on_wall():
		_state_machine.transition_to("OnWall")
	
	if Input.is_action_just_pressed("dash"):
			_state_machine.transition_to("Dash")
