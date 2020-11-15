class_name Actor
extends KinematicBody2D

signal health_changed(new_health)
signal max_health_changed(new_max_health)

export var max_health := 5
export var speed := 400

var health := max_health

onready var state_machine := $StateMachine


func take_damage(damage: int) -> void:
	health -= damage
	emit_signal("health_changed", health)
	if health < max_health:
		_die()
	
func _die():
	pass

