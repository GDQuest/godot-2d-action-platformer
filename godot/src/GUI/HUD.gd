extends Control

var player: Player

onready var health_indicator := $HealthIndicator
onready var ammo_indicator := $AmmoIndicator
onready var points_indicator := $PointsIndicator


func initialize(player: Player) -> void:
	set_player(player)


func set_player(_player: Player) -> void:
	player = _player
	player.connect("health_changed", health_indicator, "set_health")
	player.connect("max_health_changed", health_indicator, "set_max_health")
#
	player.connect("ammo_changed", ammo_indicator, "set_value")
	player.connect("points_changed", points_indicator, "set_value")
#
	health_indicator.max_health = player.max_health
	health_indicator.set_health(player.health)
#
	ammo_indicator.set_value(player.gun.ammo)
