extends Area2D

onready var animation_player := $AnimationPlayer


func _on_TrapFloorSpikes_body_entered(body : PhysicsBody2D) -> void:
	yield(get_tree().create_timer(0.3),"timeout")
	animation_player.play("Down")


func _on_HitBox_body_entered(body : PhysicsBody2D) -> void:
	if body is Player:
			body.take_damage(1)
