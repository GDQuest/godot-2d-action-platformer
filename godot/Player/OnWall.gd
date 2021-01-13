extends PlayerState

const WALL_FRICTION := 0.3

var friction_modifier := 1.0
var wall_normal := Vector2.ZERO
var release_wall := false

onready var release_timer := $ReleaseWallTimer


func _enter(_msg: Dictionary = {}) -> void:
	wall_normal = player.get_slide_collision(0).normal
	player.velocity.x = -player.speed * sign(wall_normal.x)


func _exit() -> void:
	release_wall = false
	release_timer.stop()
	friction_modifier = 1.0


func _update(_delta: float) -> void:
	player.velocity.y -= player.velocity.y * WALL_FRICTION * friction_modifier

	# If pressing input away from wall
	var away_from_wall := sign(player.movement_direction.x * wall_normal.x) > 0

	if not away_from_wall:
		release_timer.stop()
	elif release_timer.is_stopped():
		release_timer.start()

	if not release_wall:
		player.velocity.x = -player.speed * sign(wall_normal.x)
	else:
		player.velocity.x = player.movement_direction.x

	if player.movement_direction.y > 0:
		friction_modifier = 0.5
	else:
		friction_modifier = 1.0

	if not player.is_on_wall():
		_state_machine.transition_to("Fall", {"ledge_forgive": true})
		return

	if Input.is_action_just_pressed("dash"):
		_state_machine.transition_to("Dash")

	elif Input.is_action_just_pressed("jump"):
		player.velocity = player.jump_speed * wall_normal.rotated(45)
		player.velocity.x *= -1
		_state_machine.transition_to("Jump")

	if player.is_on_floor():
		_state_machine.transition_to("Idle")


func _on_ReleaseWallTimer_timeout():
	release_wall = true
