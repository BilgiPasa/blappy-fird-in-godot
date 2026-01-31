extends RigidBody2D

signal start_game

var fird_gravity_scale: int = 5
var jump_force: int = 1800
var jump_input: bool

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	gravity_scale = 0
	contact_monitor = true
	max_contacts_reported = 5

func _physics_process(_delta) -> void:
	if jump_input:
		jump_input = false
		linear_velocity = jump_force * Vector2.UP

func _input(event) -> void:
	if event.is_action_pressed("fird_jump"):
		if Globals.game_started:
			jump_input = true
		else:
			gravity_scale = fird_gravity_scale
			jump_input = true
			Globals.game_started = true
			emit_signal("start_game")
