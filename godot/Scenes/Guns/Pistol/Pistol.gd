extends Gun

onready var shoot_position := $ShootPosition
onready var shoot_timer := $ShootTimer


func _ready() -> void:
	shoot_timer.wait_time = shoot_rate


func shoot_pressed() -> void:
	if shoot_timer.is_stopped():
		shoot_timer.start()
		if ammo > 0:
			var bullet = bullet_scene.instance()
			bullet.direction = direction
			get_tree().get_root().add_child(bullet)
			bullet.global_position = shoot_position.global_position
			ammo -= 1
			emit_signal("ammo_changed", ammo)
