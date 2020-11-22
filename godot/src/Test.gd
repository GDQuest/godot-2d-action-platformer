extends Node2D

onready var player := $Player
onready var hud := $CanvasLayer/HUD

func _ready():
	hud.initialize(player)
