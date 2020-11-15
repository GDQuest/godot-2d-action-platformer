class_name Gun
extends Node2D

signal ammo_changed(new_ammo)

export (PackedScene) var bullet_scene
export var ammo := 100
export var shoot_rate := 0.25

var direction := Vector2.ZERO


func _physics_process(delta : float) -> void:
	var angle = Vector2(abs(direction.x), direction.y).angle()
	rotation = angle


func shoot_pressed() -> void:
	pass


func shoot_released() -> void:
	pass


