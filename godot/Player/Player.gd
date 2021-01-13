class_name Player
extends Actor

const FLOOR_NORMAL := Vector2.UP

export var jump_height := 192
export var jump_duration = 0.3
export var dash_distance := 600.0
export var dash_duration := 0.25

export (Array, PackedScene) var available_guns_scenes
var available_guns := []

# We calculate the gravity and jump force below.
var gravity := -1.0
var jump_speed := -1.0
var dash_speed := -1.0

var gun: Gun
var gun_index := 0

var velocity := Vector2.ZERO
var aim_direction := Vector2.RIGHT
var movement_direction := Vector2.RIGHT
var gravity_multipler := 1.0
var facing_direction := 1

var can_dash := true

# player stats
var damage_increment := 0.0
var speed_increment := 0.0

onready var is_joypad_connected := Input.get_connected_joypads().size() > 0

onready var _body = $Body
onready var _gun_position = $Body/GunPosition


func _ready() -> void:
	# To set how we should calculate aim direction
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")

	gravity = 2 * jump_height / pow(jump_duration, 2)
	jump_speed = -sqrt(2 * gravity * 384)
	dash_speed = dash_distance / dash_duration

	for gun_scene in available_guns_scenes:
		var new_gun: Gun = gun_scene.instance()
		available_guns.append(new_gun)

	gun = available_guns[0]
	_gun_position.add_child(gun)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("next_weapon"):
		_set_gun(gun_index + 1)
	elif event.is_action_pressed("previous_weapon"):
		_set_gun(gun_index - 1)


func _physics_process(delta: float) -> void:
	aim_direction = calculate_aim_direction()
	movement_direction = calculate_movement_direction()

	var new_facing_direction: float

	if is_joypad_connected:
		new_facing_direction = aim_direction.x
	else:
		new_facing_direction = global_position.direction_to(get_global_mouse_position()).x

	if not is_equal_approx(new_facing_direction, 0.0):
		facing_direction = int(sign(new_facing_direction))

	_body.scale.x = facing_direction

	gun.direction = aim_direction
	if aim_direction == Vector2.ZERO:
		gun.direction.x = facing_direction

	velocity.y += gravity * gravity_multipler * delta
	velocity = move_and_slide(velocity * (1.0 + speed_increment), FLOOR_NORMAL)
	get_global_mouse_position()


func calculate_movement_direction() -> Vector2:
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()


func calculate_aim_direction() -> Vector2:
	var direction: Vector2
	if is_joypad_connected:
		direction = calculate_movement_direction()
	else:
		direction = gun.global_position.direction_to(get_global_mouse_position())

	return direction


func _set_gun(index := 0) -> void:
	_gun_position.remove_child(gun)
	gun_index = wrapi(index, 0, available_guns.size())
	gun = available_guns[gun_index]
	_gun_position.add_child(gun)


func _on_joy_connection_changed(_device_id: int, connected: bool) -> void:
	is_joypad_connected = connected
