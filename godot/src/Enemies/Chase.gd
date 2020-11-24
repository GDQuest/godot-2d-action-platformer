extends State


func _enter(_msg := {}) -> void:
	owner.speed_modifier = 2.0


func _update(delta: float) -> void:
	if owner.target == null:
		_state_machine.transition_to("Patroll")
		return
	owner.run_direction = sign(owner.target.global_position.x - owner.global_position.x)
	owner.velocity.x = owner.speed * owner.run_direction

	if owner.target in owner.shoot_area.get_overlapping_bodies():
		_state_machine.transition_to("Shoot")