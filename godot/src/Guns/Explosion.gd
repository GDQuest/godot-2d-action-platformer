extends Node2D

signal explosion_ended

export var damage := 2
export var effect_frames := 2

onready var smoke := $Smoke
onready var sparkles := $Sparkles
onready var fire := $Fire
onready var hitbox := $HitBox


func _ready():
	yield(get_tree(), "physics_frame")
	yield(get_tree(), "physics_frame")
	_explode()


func _explode():
	smoke.emitting = true
	sparkles.emitting = true
	fire.emitting = true
	for body in hitbox.get_overlapping_bodies():
		if body.has_method("take_damage"):
			body.take_damage(damage)
	yield(get_tree().create_timer(1.1), "timeout")
	emit_signal("explosion_ended")
	queue_free()
