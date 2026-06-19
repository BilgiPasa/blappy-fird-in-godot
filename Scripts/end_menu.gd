extends Control

signal try_again
signal quit_game

@export var your_score_was_label: Label
@export var your_high_score_is_label: Label
@export var try_again_button: Button

func _on_visibility_changed() -> void:
	if visible:
		your_score_was_label.text = "Your score was " + str(Globals.score)

		# Save the high score
		if Globals.high_score_save.high_score < Globals.score:
			Globals.high_score_save.high_score = Globals.score
			Globals.high_score_save.save()

		your_high_score_is_label.text = "Your high score is " + str(Globals.high_score_save.high_score)
		try_again_button.grab_focus()

func _on_try_again_button_pressed() -> void:
	try_again.emit()

func _on_quit_game_button_pressed() -> void:
	quit_game.emit()
