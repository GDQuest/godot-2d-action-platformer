extends Control

onready var ammo_label := $HBoxContainer/Ammo


func set_ammo(new_ammo : int) -> void:
	ammo_label.text = str(new_ammo)

	
