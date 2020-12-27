class_name Player
extends Actor

signal ammo_changed(ammo)
signal points_changed(points)

const FLOOR_NORMAL := Vector2.UP

const DASH_SPEED := 3500

export (Array, PackedScene) var available_guns_scenes
var available_guns := []

var gravity : float
var jump_speed : float

var gun: Gun
var gun_index := 0

var velocity := Vector2.ZERO
var aim_direction := Vector2.RIGHT
var movement_direction := Vector2.RIGHT
var gravity_multipler := 1.0
var facing_direction := 1

# player stats
var damage_increment := 0.0
var speed_increment := 0.0
var points := 0

# input type
onready var joy_connected := Input.get_connected_joypads().size() > 0

onready var body = $Body
onready var gun_position = $Body/GunPosition


func _ready() -> void:
	# To set how we should calculate aim direction
	Input.connect("joy_connection_changed", self, "_on_joy_connection_changed")
	
	# Calculate gravity and jump speed for desired movement. This can be
	# hardcoded and make those vars consts again, once we find something we like
	
	# max height to 1.5 tile size
	var max_jump_height := 128*1.5
	# jump duration of 0.35 sec
	var jump_duration = 0.3
	# calculate gravity
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	# calculate jump speed
	jump_speed = -sqrt(2 * gravity * 384)
	
	for gun_scene in available_guns_scenes:
		var new_gun: Gun = gun_scene.instance()
		new_gun.connect("ammo_changed", self, "_on_gun_ammo_changed")
		available_guns.append(new_gun)

	gun = available_guns[0]
	gun_position.add_child(gun)

	Events.connect("enemy_died", self, "add_points")

func _unhandled_input(event: InputEvent) -> void:
	if joy_connected:
		if event.is_action_pressed("next_weapon"):
			_set_gun(gun_index + 1)
		elif event.is_action_pressed("previous_weapon"):
			_set_gun(gun_index - 1)
	else:
		if event.is_action_pressed("next_weapon"):
			_set_gun(gun_index + 1)
		if event.is_action_pressed("previous_weapon"):
			_set_gun(gun_index - 1)

func _physics_process(delta: float) -> void:
	aim_direction = calculate_aim_direction()
	movement_direction = calculate_movement_direction()
	
	var new_facing_direction : float
	
	if not joy_connected:
		new_facing_direction = global_position.direction_to(get_global_mouse_position()).x
	else:
		new_facing_direction = aim_direction.x
		
	if not is_equal_approx(new_facing_direction, 0.0):
		facing_direction = sign(new_facing_direction)
		
	body.scale.x = facing_direction

	
	gun.direction = aim_direction
	if aim_direction == Vector2.ZERO:
		gun.direction.x = facing_direction

	velocity.y += gravity * gravity_multipler * delta
	velocity = move_and_slide(velocity * (1.0 + speed_increment), FLOOR_NORMAL)
	get_global_mouse_position()


func calculate_movement_direction() -> Vector2:
	return Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"), Input.get_action_strength("down") - Input.get_action_strength("up")).normalized()


func calculate_aim_direction() -> Vector2:
	var aim_direction : Vector2
	if joy_connected:
		aim_direction = calculate_movement_direction()
	else:
		aim_direction = gun.global_position.direction_to(get_global_mouse_position())
	
	return aim_direction

func _on_gun_ammo_changed(new_ammo):
	emit_signal("ammo_changed", new_ammo)


func _set_gun(index := 0) -> void:
	gun_position.remove_child(gun)
	gun_index = wrapi(index, 0, available_guns.size())
	gun = available_guns[gun_index]
	gun_position.add_child(gun)
	emit_signal("ammo_changed", gun.ammo)
	
func add_points(_points : int) -> void:
	points += _points
	emit_signal("points_changed", points)

func _on_joy_connection_changed(device_id : int, connected : bool) -> void:
	joy_connected = connected
