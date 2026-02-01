extends StaticBody2D

signal scored

@export var score_area: Area2D
const SPEED: int = 20

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE

func _physics_process(_delta):
	position += SPEED * Vector2.LEFT

	if position.x < -1250:
		queue_free()

func _on_score_area_body_exited(_body: Node2D) -> void:
	disable_coll_and_emit.call_deferred()

func disable_coll_and_emit() -> void:
	score_area.monitoring = false
	scored.emit()
