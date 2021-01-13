extends State


func _enter(_msg := {}) -> void:
	owner.speed_modifier = 1.0


func _update(delta: float) -> void:
	owner.velocity.x = owner.speed * owner.run_direction

	owner.raycast_floor.force_raycast_update()
	owner.raycast_wall.force_raycast_update()

	if (
		owner.is_on_floor()
		and (not owner.raycast_floor.is_colliding() or owner.raycast_wall.is_colliding())
	):
		owner.run_direction *= -1

	if owner.target != null:
		_state_machine.transition_to("Chase")
