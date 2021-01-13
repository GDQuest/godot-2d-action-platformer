extends Control

var _player: Player

onready var _health_indicator := $HealthIndicator


func initialize(player: Player) -> void:
	set_player(player)


func set_player(value: Player) -> void:
	_player = value
	_player.connect("health_changed", _health_indicator, "set_health")
	_player.connect("max_health_changed", _health_indicator, "set_max_health")

	_health_indicator.max_health = _player.max_health
	_health_indicator.set_health(_player.health)
