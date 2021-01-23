extends RigidBody2D

const Explosion := preload("Explosion.tscn")

export var max_impulse := 2000.0

var direction := Vector2.RIGHT setget set_direction
var charge := 0.0 setget set_charge

onready var _sprite := $Sprite


func _on_Timer_timeout():
	var explosion = Explosion.instance()
	Projectiles.add_child(explosion)
	explosion.global_position = global_position
	queue_free()


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction


func set_charge(new_charge: float) -> void:
	charge = new_charge
	apply_central_impulse(direction * max_impulse * charge)
