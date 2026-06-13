extends Node

var game_started: bool = false
var game_paused: bool = false
var game_ended: bool = false
var score: int = 0
var high_score_save: HighScoreSave

func _ready():
	high_score_save = HighScoreSave.load_or_create()
