extends Area2D

const GRAVITY := 1800.0

var is_falling := false
var speed := 0.0

onready var sprite := $Sprite
onready var ray_cast := $RayCast2D
onready var original_position := global_position


func _physics_process(delta : float) -> void:
	if is_falling:
		speed += GRAVITY*delta
		global_position.y += speed*delta
	else:
		if ray_cast.is_colliding():
			is_falling = true
			ray_cast.enabled = false


func _on_TrapFallingThorn_body_entered(body : PhysicsBody2D) -> void:
	if not is_falling: 
		return
	is_falling = false
	speed = 0.0
	if body is Player:
		body.take_damage(1)
		hide()
	else:
		sprite.frame = 1
	_restore()


func _restore() -> void:
	yield(get_tree().create_timer(1),"timeout")
	show()
	sprite.frame = 0
	global_position = original_position
	ray_cast.enabled = true
	
