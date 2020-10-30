extends State


func _update(delta : float) -> void:
	if owner.is_on_floor():
		owner.velocity.x = owner.speed * (Input.get_action_strength("Right") -
		Input.get_action_strength("Left"))
		
		if is_equal_approx(owner.velocity.x, 0.0):
			_transition_to("Idle") 
		
		if Input.is_action_just_pressed( "Jump" ):
			_transition_to("Jump")
			
		if Input.is_action_just_pressed("Dash"):
			_transition_to("Dash")
			
	else:
		_transition_to("Fall", {"ledge_forgive" : true})
