extends Node2D

onready var player := $Player
onready var hud := $CanvasLayer/HUD
onready var stats_menu := $CanvasLayer/UIStatsMenu


func _ready() -> void:
	hud.initialize(player)
	stats_menu.initialize(player)
