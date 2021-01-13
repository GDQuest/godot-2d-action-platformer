tool
extends TextureRect

signal purchased_stat(increment)

export var needed_points := 1 setget set_needed_points
export var stat_increment := 0.1 setget set_stat_increment
export var is_increment_relative := true

var _player: Player

onready var _button := $Button
onready var _label := $Label


func initialize(player: Player) -> void:
	_player = player


func set_needed_points(points: int) -> void:
	needed_points = points
	if not is_inside_tree():
		yield(self, "ready")
	_button.text = str(points)


func set_stat_increment(increment: float) -> void:
	stat_increment = increment
	if not is_inside_tree():
		yield(self, "ready")
	if is_increment_relative:
		_label.text = "+" + str(increment * 100) + "%"
	else:
		_label.text = "+" + str(increment)


func _on_Button_pressed() -> void:
	if _player.points >= needed_points:
		_player.add_points(-needed_points)
		self.needed_points *= 2
		emit_signal("purchased_stat", stat_increment)
