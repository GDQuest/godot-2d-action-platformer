extends Control

var max_health : int setget set_max_health
var hearth_scene := preload("res://src/GUI/Heart.tscn")
onready var hearth_container := $HearthContainer


func set_max_health(_max_health : int) -> void:
	max_health = _max_health
	for i in max_health:
		hearth_container.add_child(hearth_scene.instance())


func set_health(new_health: int) -> void:
	for i in max_health:
		hearth_container.get_child(i).filled = i < new_health
