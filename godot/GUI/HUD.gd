extends Control

var _player: Player

onready var _health_indicator := $HealthIndicator
onready var _ammo_indicator := $AmmoIndicator
onready var _points_indicator := $PointsIndicator


func initialize(player: Player) -> void:
	set_player(player)


func set_player(value: Player) -> void:
	_player = value
	_player.connect("health_changed", _health_indicator, "set_health")
	_player.connect("max_health_changed", _health_indicator, "set_max_health")
#
	_player.connect("ammo_changed", _ammo_indicator, "set_value")
	_player.connect("points_changed", _points_indicator, "set_value")
#
	_health_indicator.max_health = _player.max_health
	_health_indicator.set_health(_player.health)
#
	_ammo_indicator.set_value(_player.gun.ammo)
