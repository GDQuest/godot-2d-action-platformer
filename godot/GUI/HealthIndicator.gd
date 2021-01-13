extends Control

const Hearth: PackedScene = preload("Heart.tscn")

var max_health: int setget set_max_health

onready var _hearth_container := $HearthContainer


func set_max_health(value: int) -> void:
	max_health = value

	for hearth in _hearth_container.get_children():
		hearth.queue_free()
	for i in max_health:
		_hearth_container.add_child(Hearth.instance())


func set_health(new_health: int) -> void:
	for i in max_health:
		_hearth_container.get_child(i).filled = i < new_health
