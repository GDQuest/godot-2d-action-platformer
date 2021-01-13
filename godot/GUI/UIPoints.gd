tool
extends UIValueDisplay


func _ready() -> void:
	Events.connect("enemy_died", self, "increment_value")
