class_name State
extends Node

onready var _state_machine := get_parent()


func _ready() -> void:
	yield(owner, "ready")


func _update(_delta: float) -> void:
	pass


func _enter(_msg := {}) -> void:
	pass


func _exit() -> void:
	pass
