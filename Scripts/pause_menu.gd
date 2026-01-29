extends Control

signal resume
signal quit_game

@export var resume_button: Button

# Buraya "_on_resume_button_pressed" ve "_on_quit_game_button_pressed" fonksiyonlarını ekle.

func _on_visibility_changed() -> void:
	if visible:
		resume_button.grab_focus()

""" Bu arada haberin olsun, UI navigation'da WASD kullanabiliyorum çünkü; "Project Settings"te "Input Map"te
"Show Built-in Actions" seçeneğini aktive ettim ve ui_up, ui_down, ui_right ve ui_left kısımlarına WASD
tuşlarını ekledim. """
