extends State

var wall_normal := Vector2.ZERO
var wall_friction := 0.3


func _enter(_msg: Dictionary = {}) -> void:
	wall_normal = owner.get_slide_collision(0).normal


func _update(delta : float) -> void:
	owner.velocity.y -= owner.velocity.y * wall_friction
	owner.velocity.x = owner.speed * (Input.get_action_strength("right") -
		Input.get_action_strength("left"))
		
	if owner.velocity.x == 0:
		owner.velocity.x = -owner.speed * sign(wall_normal.x)
	
	# Calculate aim direction according to movement inputs
			
	var vertical_aim := Input.get_action_strength("down") - Input.get_action_strength("up")
	var horizontal_aim : float = sign(wall_normal.x)

	owner.aim_direction = Vector2(horizontal_aim, vertical_aim).normalized()

	if owner.aim_direction == Vector2.ZERO:
		owner.aim_direction = Vector2.RIGHT*owner.facing_direction
	
	if !owner.is_on_wall():
		_state_machine.transition_to("Fall", {"ledge_forgive" : true})
		return

	if Input.is_action_just_pressed("jump"):
		owner.velocity = owner.JUMP_SPEED * wall_normal.rotated(45)
		owner.velocity.x *= -1
		_state_machine.transition_to("Jump")
		
	if Input.is_action_just_pressed("dash"):
			_state_machine.transition_to("Dash")
