extends RigidBody2D

signal scored

var speed: int = 20

func _ready() -> void:
	freeze_mode = RigidBody2D.FREEZE_MODE_KINEMATIC
	freeze = true
	self.linear_velocity = speed * Vector2.LEFT
