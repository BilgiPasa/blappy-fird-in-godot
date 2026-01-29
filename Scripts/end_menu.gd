extends Control

signal try_again
signal quit_game

@export var your_score_was_label: Label
@export var try_again_button: Button

# Buraya "_on_try_again_button_pressed" ve "_on_quit_game_button_pressed" fonksiyonlarını ekle.

func _on_visibility_changed() -> void:
	if visible:
		your_score_was_label.text = "Your score was " + str(Globals.score)
		try_again_button.grab_focus()

""" Bu arada haberin olsun, UI navigation'da WASD kullanabiliyorum çünkü; Project Settings'te Input Map'te
Show Built-in Actions seçeneğini aktive ettim ve ui_up, ui_down, ui_right ve ui_left kısımlarına WASD
tuşlarını ekledim. """
