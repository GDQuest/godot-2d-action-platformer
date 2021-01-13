extends Control

var _player: Player

onready var _damage_button := $HBoxContainer/DamageButton
onready var _speed_button := $HBoxContainer/SpeedButton
onready var _health_button := $HBoxContainer/HealthButton


func _input(event):
	if event.is_action_pressed("Menu"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused


func initialize(player: Player) -> void:
	_player = player
	_damage_button.initialize(_player)
	_speed_button.initialize(_player)
	_health_button.initialize(_player)


func _on_DamageButton_purchased_stat(increment: float) -> void:
	_player.damage_increment = increment


func _on_SpeedButton_purchased_stat(increment: float) -> void:
	_player.speed_increment = increment


func _on_HealthButton_purchased_stat(increment: int) -> void:
	_player.max_health += increment
	_player.health = _player.max_health
