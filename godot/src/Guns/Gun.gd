class_name Gun
extends Node2D

signal ammo_changed(new_ammo)

enum MODE {NORMAL, AUTOMATIC, CHARGE}

export (PackedScene) var bullet_scene
export var max_ammo := 100
export var shoot_rate := 0.25 
export (MODE) var mode := MODE.NORMAL

var ammo := max_ammo
var direction := Vector2.ZERO

onready var shoot_timer := $ShootTimer
onready var shoot_position := $ShootPosition


func _ready():
	shoot_timer.wait_time = shoot_rate


func _physics_process(delta : float) -> void:
	var angle = Vector2(abs(direction.x), direction.y).angle()
	rotation = angle
	
	match mode:
		MODE.NORMAL:
			if Input.is_action_just_pressed("shoot") and _can_shoot():
				_shoot()
		MODE.AUTOMATIC:
			if Input.is_action_pressed("shoot") and _can_shoot():
				_shoot()
		MODE.CHARGE:
			pass
			
func _shoot() -> void:
	shoot_timer.start()
	var bullet = bullet_scene.instance()
	bullet.direction = direction
	get_tree().get_root().add_child(bullet)
	bullet.global_position = shoot_position.global_position
	ammo -= 1
	emit_signal("ammo_changed", ammo)

func _can_shoot() -> bool:
	return shoot_timer.is_stopped() and ammo > 0

