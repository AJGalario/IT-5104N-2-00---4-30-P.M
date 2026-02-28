extends StaticBody2D

func _physics_process(delta: float) -> void:
	position.x -= Global.platform_speed * delta
