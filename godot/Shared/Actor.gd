class_name Actor
extends KinematicBody2D

signal health_changed(new_health)
signal max_health_changed(new_max_health)

export var max_health := 5 setget set_max_health

# trhee tiles in a second.
export var speed := 768

var health := max_health

onready var state_machine := $StateMachine


func take_damage(damage: int) -> void:
	health -= damage
	emit_signal("health_changed", health)
	if health < max_health:
		_die()


func _die():
	pass


func set_max_health(new_max_health: int) -> void:
	max_health = new_max_health
	emit_signal("max_health_changed", max_health)
