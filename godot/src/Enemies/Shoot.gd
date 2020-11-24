extends State

onready var shoot_timer := $ShootTimer


func _enter(_msg := {}) -> void:
	owner.speed_modifier = 0.0


func _update(delta: float) -> void:
	if owner.target == null:
		_state_machine.transition_to("Patroll")
		return

	var direction_to_target: Vector2 = owner.global_position.direction_to(
		owner.target.global_position
	)
	owner.run_direction = sign(direction_to_target.x)

	if shoot_timer.is_stopped():
		shoot_timer.start()
		var bullet: AreaBullet = owner.bullet_scene.instance()
		bullet.direction = direction_to_target
		get_tree().get_root().add_child(bullet)
		bullet.global_position = owner.shoot_position.global_position

	if not owner.target in owner.shoot_area.get_overlapping_bodies():
		_state_machine.transition_to("Chase")
