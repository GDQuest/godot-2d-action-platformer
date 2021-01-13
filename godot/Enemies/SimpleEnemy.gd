class_name SimpleEnemy
extends Actor

const FLOOR_NORMAL := Vector2.UP
const GRAVITY := 1800

var velocity := Vector2.ZERO
var run_direction := -1
var speed_modifier := 1.0
var target = null

export (PackedScene) var bullet_scene = preload("EnemyBullet.tscn")
export var points := 1

onready var raycast_floor := $Body/FloorRayCast
onready var raycast_wall := $Body/WallRayCast
onready var shoot_position := $Body/ShootPosition
onready var shoot_area := $ShootArea

onready var body := $Body


func _physics_process(delta):
	body.scale.x = -run_direction

	velocity.y += GRAVITY * delta
	velocity.x *= speed_modifier
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	get_global_mouse_position()


func _on_DetectionArea_body_entered(body):
	target = body


func _on_DetectionArea_body_exited(_body):
	target = null


func _die():
	Events.emit_signal("enemy_died", points)
	queue_free()
