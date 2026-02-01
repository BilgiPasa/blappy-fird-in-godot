extends RigidBody2D

signal scored

@export var score_area: Area2D
const SPEED: int = 20

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	freeze = true

func _physics_process(_delta) -> void:
	position += SPEED * Vector2.LEFT

	if position.x < -1500:
		queue_free()

func _on_score_area_body_exited(_body: Node2D) -> void:
	disable_and_emit.call_deferred()

func disable_and_emit() -> void:
	score_area.process_mode = Node.PROCESS_MODE_DISABLED
	scored.emit()
