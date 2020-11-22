extends Area2D

var _is_out := false

onready var animation_player := $AnimationPlayer


func _on_TrapFloorSpikes_body_entered(body):
	if not _is_out:
		_is_out = true
		yield(get_tree().create_timer(0.3),"timeout")
		animation_player.play("Down")
	_hit_player()


func _hit_player():
	for body in get_overlapping_bodies():
		if body is Player:
			body.take_damage(1)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Down":
		_is_out = false
