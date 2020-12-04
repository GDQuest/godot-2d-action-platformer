extends Control

var player: Player

onready var damage_button := $HBoxContainer/DamageButton
onready var speed_button := $HBoxContainer/SpeedButton
onready var health_button := $HBoxContainer/HealthButton


func _input(event):
	if event.is_action_pressed("Menu"):
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused


func initialize(_player: Player) -> void:
	player = _player
	damage_button.initialize(player)
	speed_button.initialize(player)
	health_button.initialize(player)


func _on_DamageButton_purchased_stat(increment : float) -> void:
	player.damage_increment = increment


func _on_SpeedButton_purchased_stat(increment : float) -> void:
	player.speed_increment = increment


func _on_HealthButton_purchased_stat(increment : float) -> void:
	player.max_health += increment
