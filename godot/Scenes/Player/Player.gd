class_name Player
extends Actor

const FLOOR_NORMAL := Vector2.UP
const GRAVITY := 1800
const JUMP_SPEED := -900
const DASH_SPEED := 2400

var velocity := Vector2.ZERO
var gravity_modifier := 1.0


func _physics_process(delta):
	velocity.y += GRAVITY * gravity_modifier * delta
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	get_global_mouse_position()


