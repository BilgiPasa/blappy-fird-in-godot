extends Node2D

@export var fird: RigidBody2D
@export var start_menu: Control # Has nothing to do with proccess mode change
@export var pause_menu: Control
@export var end_menu: Control
@export var score_label: Label # Has nothing to do with proccess mode change
@onready var wall_generate_timer: Timer = $WallGenerateTimer
@onready var reduce_wall_generate_timer: Timer = $ReduceWallGenerateTimer
var walls_max_offset: int = 150
var wall_generate_seconds: float = 1.5
var reduce_wall_generate_seconds: float = 1.5
var reduce_time_amount: float = 0.1
var rng: RandomNumberGenerator = RandomNumberGenerator.new();
var walls_scene = preload("res://Scenes/walls.tscn")

func _ready():
	start_menu.show()
	pause_menu.process_mode = Node.PROCESS_MODE_DISABLED
	pause_menu.hide()
	end_menu.process_mode = Node.PROCESS_MODE_DISABLED
	end_menu.hide()
	score_label.hide()

func _physics_process(_delta):
	if Globals.game_ended:
		wall_generate_timer.stop()
		reduce_wall_generate_timer.stop()

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if Globals.game_started:
			if !Globals.game_paused:
				if !Globals.game_ended:
					pause()
				else:
					quit_game()
			else:
				resume()
		else:
			quit_game()

func pause() -> void:
	Engine.time_scale = 0
	Globals.game_paused = true
	pause_menu.process_mode = Node.PROCESS_MODE_INHERIT
	pause_menu.show()

func resume() -> void:
	Engine.time_scale = 1
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
	reduce_wall_generate_timer.start(reduce_wall_generate_seconds)

func _on_wall_generate_timer_timeout() -> void:
	var new_walls_scene = walls_scene.instantiate()
	new_walls_scene.position.x = 1500
	new_walls_scene.position.y = rng.randi_range(-walls_max_offset, walls_max_offset)
	new_walls_scene.scored.connect(scored)
	add_child(new_walls_scene)
	wall_generate_timer.wait_time = wall_generate_seconds

func scored() -> void:
	Globals.score += 1
	score_label.text = str(Globals.score)

func _on_reduce_wall_generate_timer_timeout() -> void:
	wall_generate_seconds -= reduce_time_amount

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

# Add the signal that the fird collided and add the game_end function to it.

func game_end() -> void:
	Engine.time_scale = 0
	Globals.game_ended = true
	Globals.game_paused = false
	end_menu.process_mode = Node.PROCESS_MODE_INHERIT
	end_menu.show()
