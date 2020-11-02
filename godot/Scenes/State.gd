class_name State
extends Node2D

onready var _state_machine := get_parent()


func _ready() -> void:
	yield(owner, "ready")


func _update(delta : float) -> void:
	pass


func _enter(_msg: Dictionary = {}) -> void:
	pass


func _exit() -> void:
	pass

