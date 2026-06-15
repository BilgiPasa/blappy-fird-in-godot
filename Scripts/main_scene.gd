extends Node2D

@export var fird: RigidBody2D
@export var start_menu: Control # No proccess mode change needed
@export var pause_menu: Control
@export var end_menu: Control
@export var score_label: Label # No proccess mode change needed
@onready var wall_generate_timer: Timer = $WallGenerateTimer
@onready var wg_increaser_timer: Timer = $WGIncreaserTimer # WG = Wall Generate
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound # No proccess mode change needed
@onready var game_end_sound: AudioStreamPlayer2D = $GameEndSound # No proccess mode change needed
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound # No proccess mode change needed
const WALLS_MAX_OFFSET: int = 150
const WG_INCREASER_SECONDS: float = 10 # WG = Wall Generate
const REDUCE_SECONDS_AMOUNT: float = 0.1
const WALLS_SCENE = preload("res://Scenes/walls.tscn")
var wall_generate_seconds: float = 1.5
var rng: RandomNumberGenerator = RandomNumberGenerator.new();

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	start_menu.show()
	pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	pause_menu.hide()
	end_menu.process_mode = Node.PROCESS_MODE_DISABLED
	end_menu.hide()
	score_label.hide()
	wall_generate_timer.process_mode = Node.PROCESS_MODE_PAUSABLE
	wg_increaser_timer.process_mode = Node.PROCESS_MODE_PAUSABLE

func _physics_process(_delta):
	# Instead of changing the time scale, you can just pause the game.
	if Globals.game_paused:
		get_tree().paused = true
	else:
		get_tree().paused = false

	# If game ends, stop the timers.
	if Globals.game_ended:
		wall_generate_timer.stop()
		wg_increaser_timer.stop()

func _input(event):
	if event.is_action_pressed("ui_cancel"): # If "esc" key pressed
		if Globals.game_started && !Globals.game_ended:
			if !Globals.game_paused:
				pause()
			else:
				resume()
		else:
			quit_game()

func pause() -> void:
	Globals.game_paused = true
	pause_menu.process_mode = Node.PROCESS_MODE_INHERIT
	pause_menu.show()

func resume() -> void:
	Globals.game_paused = false
	pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	pause_menu.hide()

func quit_game() -> void:
	get_tree().quit()

func _on_fird_start_game() -> void:
	score_label.show()
	start_menu.hide()
	score_label.text = "0"
	wall_generate_timer.start(wall_generate_seconds)
	wg_increaser_timer.start(WG_INCREASER_SECONDS)

func _on_fird_play_jump_sound() -> void:
	jump_sound.play()

func _on_wall_generate_timer_timeout() -> void:
	var new_ws = WALLS_SCENE.instantiate() # new_walls_scene
	new_ws.position = Vector2(1250, rng.randi_range(-WALLS_MAX_OFFSET, WALLS_MAX_OFFSET))
	new_ws.scored.connect(scored)
	add_child(new_ws)
	wall_generate_timer.wait_time = wall_generate_seconds

func scored() -> void:
	score_sound.play()
	Globals.score += 1
	score_label.text = str(Globals.score)

func _on_wg_increaser_timer_timeout() -> void:
	if wall_generate_seconds > REDUCE_SECONDS_AMOUNT:
		wall_generate_seconds -= REDUCE_SECONDS_AMOUNT

func _on_pause_menu_quit_game() -> void:
	quit_game()

func _on_pause_menu_resume() -> void:
	resume()

func _on_end_menu_quit_game() -> void:
	quit_game()

func _on_end_menu_try_again() -> void:
	try_again()

func try_again() -> void:
	Globals.game_started = false
	Globals.game_paused = false
	Globals.game_ended = false
	Globals.score = 0
	get_tree().reload_current_scene()

func _on_fird_body_entered(_body: Node) -> void:
	end_game()

func _on_ceiling_area_body_entered(_body: Node2D) -> void:
	end_game()

func _on_floor_area_body_entered(_body: Node2D) -> void:
	end_game()

func end_game() -> void:
	Globals.game_paused = true # To pause the game after it ends
	Globals.game_ended = true
	game_end_sound.play()
	end_menu.process_mode = Node.PROCESS_MODE_INHERIT
	end_menu.show()
	score_label.hide()
	pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	pause_menu.hide()
