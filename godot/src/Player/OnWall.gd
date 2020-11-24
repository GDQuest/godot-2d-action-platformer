extends PlayerState

var wall_normal := Vector2.ZERO
var wall_friction := 0.3


func _enter(_msg: Dictionary = {}) -> void:
	wall_normal = player.get_slide_collision(0).normal


func _update(_delta: float) -> void:
	player.aim_direction = player.calculate_input_direction()
	player.velocity.y -= player.velocity.y * wall_friction
	player.velocity.x = player.speed * player.aim_direction.x

	if is_equal_approx(player.velocity.x, 0):
		player.velocity.x = -player.speed * sign(wall_normal.x)

	if not player.is_on_wall():
		_state_machine.transition_to("Fall", {"ledge_forgive": true})
		return

	if Input.is_action_just_pressed("dash"):
		_state_machine.transition_to("Dash")
	elif Input.is_action_just_pressed("jump"):
		player.velocity = player.JUMP_SPEED * wall_normal.rotated(45)
		player.velocity.x *= -1
		_state_machine.transition_to("Jump")
