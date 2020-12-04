tool
extends Control

export (Texture) var icon_texture setget set_icon_texture

onready var value_label := $HBoxContainer/Value
onready var icon := $HBoxContainer/Icon


func set_value(value: int) -> void:
	value_label.text = str(value)
	
func set_icon_texture(texture : Texture) -> void:
	if not is_inside_tree():
		yield(self, "ready")
	icon_texture = texture
	icon.texture = texture
	
