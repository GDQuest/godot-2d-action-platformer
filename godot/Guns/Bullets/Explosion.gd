extends Node2D

signal explosion_ended

export var damage := 2
export var effect_frames := 2

onready var _smoke := $Smoke
onready var _sparkles := $Sparkles
onready var _fire := $Fire
onready var _hitbox := $HitBox


func _ready():
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	_explode()


func _explode():
	_smoke.emitting = true
	_sparkles.emitting = true
	_fire.emitting = true
	for body in _hitbox.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(damage)
	yield(get_tree().create_timer(1.1), "timeout")
	emit_signal("explosion_ended")
	queue_free()
