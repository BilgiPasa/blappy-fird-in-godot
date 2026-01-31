extends RigidBody2D

signal scored

var speed: int = 20

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_PAUSABLE
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	freeze = true

func _physics_process(_delta) -> void:
	position += speed * Vector2.LEFT

	if position.x < -1500:
		queue_free()

func _on_area_2d_body_exited(_body: Node2D) -> void:
	emit_signal("scored")
