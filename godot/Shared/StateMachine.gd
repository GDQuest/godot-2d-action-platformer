class_name StateMachine
extends Node

export var initial_state := NodePath()

onready var state: State = get_node(initial_state) setget set_state
onready var _state_name := state.name


func _init() -> void:
	add_to_group("state_machine")


func _ready() -> void:
	yield(owner, "ready")
	state._enter()


func _physics_process(delta: float) -> void:
	state._update(delta)


func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		return

	var target_state := get_node(target_state_path)

	state._exit()
	self.state = target_state
	state._enter(msg)


func set_state(value: State) -> void:
	state = value
	_state_name = state.name
