extends Node2D

onready var _player := $Player
onready var _hud := $CanvasLayer/HUD
onready var _stats_menu := $CanvasLayer/UIStatsMenu


func _ready() -> void:
	_hud.initialize(_player)
	_stats_menu.initialize(_player)
