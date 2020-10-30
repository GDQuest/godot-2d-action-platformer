extends State

onready var _input_buffer := $InputBufferingTimer
onready var _ledge_forgive := $LedgeForgivenessTimer


func _enter(_msg: Dictionary = {}) -> void:
	_ledge_forgive.stop()
	if "ledge_forgive" in _msg:
		if _msg.ledge_forgive: 
			_ledge_forgive.start() 


func _update(delta : float) -> void:
	if owner.is_on_floor():
		if !_input_buffer.is_stopped():
			_transition_to("Jump")
		else:
			_transition_to("Idle")
		
	var target_speed = owner.speed * (Input.get_action_strength("Right") -
		Input.get_action_strength("Left"))
		
	if Input.is_action_just_pressed("Jump"):
		if !_ledge_forgive.is_stopped():
			_transition_to("Jump")
		else:
			_input_buffer.start()
			
	if owner.is_on_wall():
		_transition_to("OnWall")
	
	owner.velocity.x = lerp(owner.velocity.x, target_speed, 0.1)
	
	if Input.is_action_just_pressed("Dash"):
			_transition_to("Dash")
