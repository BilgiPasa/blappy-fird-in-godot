extends StaticBody2D

signal scored

const SPEED: int = 20
var emmited: bool = false

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _physics_process(_delta):
	position += SPEED * Vector2.LEFT

	if position.x < -1250:
		queue_free()

func _on_score_area_body_exited(_body: Node2D) -> void:
	if !emmited:
		emmited = true
		scored.emit()
