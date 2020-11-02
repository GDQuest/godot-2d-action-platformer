class_name Player
extends Actor

const FLOOR_NORMAL := Vector2.UP
const GRAVITY := 1800
const JUMP_SPEED := -900
const DASH_SPEED := 2400

var velocity := Vector2.ZERO
var aim_direction := Vector2.RIGHT
var gravity_modifier := 1.0
var facing_direction := 1


func _physics_process(delta):
	var vertical_aim := Input.get_action_strength("Down") - Input.get_action_strength("Up")
	var horizontal_aim := Input.get_action_strength("Right") - Input.get_action_strength("Left")
	
	if horizontal_aim != 0.0:
		facing_direction = sign(horizontal_aim)
	
	aim_direction = Vector2(horizontal_aim, vertical_aim).normalized()
	if aim_direction == Vector2.ZERO:
		aim_direction = Vector2.RIGHT*facing_direction
	
	velocity.y += GRAVITY * gravity_modifier * delta
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	get_global_mouse_position()


