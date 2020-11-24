extends RigidBody2D

const max_impulse := 1000.0

var explosion_scene := preload("res://src/Guns/Explosion.tscn")
var direction := Vector2.RIGHT setget set_direction
var charge := 0.0 setget set_charge


func _on_Timer_timeout():
	var explosion = explosion_scene.instance()
	get_parent().add_child(explosion)
	explosion.position = global_position
	queue_free()


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction


func set_charge(new_charge: float) -> void:
	charge = new_charge
	apply_central_impulse(direction * max_impulse * charge)
