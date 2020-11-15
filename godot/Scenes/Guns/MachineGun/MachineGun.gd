extends Gun

var shooting := false

onready var shoot_timer := $ShootTimer
onready var shoot_position := $ShootPosition

func _physics_process(delta):
	if shooting and shoot_timer.is_stopped():
		shoot_timer.start()
		if ammo > 0:
			var bullet = bullet_scene.instance()
			bullet.direction = direction
			get_tree().get_root().add_child(bullet)
			bullet.global_position = shoot_position.global_position
			ammo -= 1
			emit_signal("ammo_changed", ammo)
			
func shoot_pressed():
	shooting = true
	
func shoot_released():
	shooting = false
	shoot_timer.stop()
