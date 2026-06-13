extends RigidBody2D

signal start_game

const FIRD_GRAVITY_SCALE: int = 5
const JUMP_FORCE: int = 1750
var jump_input: bool

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	gravity_scale = 0
	contact_monitor = true
	max_contacts_reported = 1
	continuous_cd = RigidBody2D.CCD_MODE_CAST_RAY

func _physics_process(_delta) -> void:
	if jump_input:
		jump_input = false
		linear_velocity = JUMP_FORCE * Vector2.UP

func _input(event) -> void:
	if event.is_action_pressed("fird_jump"):
		if Globals.game_started:
			jump_input = true
		else:
			gravity_scale = FIRD_GRAVITY_SCALE
			jump_input = true
			Globals.game_started = true
			start_game.emit()
