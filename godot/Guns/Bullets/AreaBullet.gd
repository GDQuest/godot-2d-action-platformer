class_name AreaBullet
extends Area2D

export var speed := 2000

var damage := 1
var direction := Vector2.RIGHT setget set_direction


func _ready() -> void:
	connect("body_entered", self, "hit_body")


func _physics_process(delta: float) -> void:
	global_position += speed * delta * direction.normalized()


func hit_body(body) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
	_destroy()


func _destroy() -> void:
	queue_free()


func set_direction(new_direction: Vector2) -> void:
	direction = new_direction
	rotation = new_direction.angle()
