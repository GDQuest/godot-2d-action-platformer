extends State


func _update(delta : float) -> void:
	owner.velocity.x = 0
	if owner.is_on_floor():
		if Input.is_action_pressed("Left") or \
			Input.is_action_pressed("Right"):
				_transition_to("Run")
		
		if Input.is_action_just_pressed("Jump"):
			_transition_to("Jump")
			
		if Input.is_action_just_pressed("Dash"):
			_transition_to("Dash")
		
	else:
		_transition_to("Fall", {"ledge_forgive" : true})

