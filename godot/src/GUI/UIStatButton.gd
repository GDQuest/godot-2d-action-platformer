tool
extends TextureRect

signal purchased_stat(increment)

export var needed_points := 1 setget set_needed_points
export var stat_increment := 0.1 setget set_stat_increment
export var is_increment_relative := true

var player: Player

onready var button := $Button
onready var label := $Label


func initialize(_player: Player) -> void:
	player = _player


func set_needed_points(points : int) -> void:
	needed_points = points
	if not is_inside_tree():
		yield(self, "ready")
	button.text = str(points)


func set_stat_increment(increment : float) -> void:
	stat_increment = increment
	if not is_inside_tree():
		yield(self, "ready")
	if is_increment_relative:
		label.text = "+" + str(increment * 100) + "%"
	else:
		label.text = "+" + str(increment)



func _on_Button_pressed() -> void:
	if player.points >= needed_points:
		player.add_points(-needed_points)
		self.needed_points *= 2
		emit_signal("purchased_stat", stat_increment)
