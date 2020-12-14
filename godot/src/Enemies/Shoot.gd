extends State

var direction_to_target := Vector2.ZERO

onready var shoot_timer := $ShootTimer


func _enter(_msg := {}) -> void:
	owner.speed_modifier = 0.0
	shoot_timer.start()


func _exit() -> void:
	shoot_timer.stop()
	# Temporary because of how I indicate enemy anticipation
	owner.modulate = Color.white


func _update(_delta: float) -> void:
	if owner.target == null:
		_state_machine.transition_to("Patroll")
		return
	direction_to_target = owner.global_position.direction_to(
		owner.target.global_position
	)
	owner.run_direction = sign(direction_to_target.x)
	
	# This is temporary to indicate enemy is about to shoot you
	owner.modulate = Color(shoot_timer.time_left, 1, shoot_timer.time_left)

	if not owner.target in owner.shoot_area.get_overlapping_bodies():
		_state_machine.transition_to("Chase")

func _on_ShootTimer_timeout():
	var bullet: AreaBullet = owner.bullet_scene.instance()
	bullet.direction = direction_to_target
	get_tree().get_root().add_child(bullet)
	bullet.global_position = owner.shoot_position.global_position


