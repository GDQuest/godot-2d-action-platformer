extends TextureRect

var filled := true setget set_filled


func set_filled(_filled : bool) -> void:
	filled = _filled
	if filled:
		modulate = Color.white
	else:
		modulate = Color.black
