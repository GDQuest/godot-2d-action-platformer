class_name UIValueDisplay
extends Control

export (Texture) var icon_texture setget set_icon_texture

var _value := 0

onready var _value_label := $HBoxContainer/Value
onready var _icon := $HBoxContainer/Icon


func increment_value(amount: int) -> void:
	_value += amount
	_value_label.text = str(_value)

func set_icon_texture(texture: Texture) -> void:
	if not is_inside_tree():
		yield(self, "ready")
	icon_texture = texture
	_icon.texture = texture
