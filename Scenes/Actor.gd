class_name Actor
extends KinematicBody2D

export var max_health := 10
export var speed := 400

var health := max_health

onready var state_machine := $StateMachine

func take_damage(damage: float):
	health -= damage

