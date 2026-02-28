extends Node2D
@export var platforms: Array[PackedScene]

@onready var marker: Marker2D = $Marker2D
func _on_timer_timeout() -> void:
	
	var plat :PackedScene= platforms.pick_random()
	var plat_instance: Node = plat.instantiate()
	
	add_child(plat_instance)
	
	plat_instance.position = marker.position
	
	var random_y_position: float = randf_range(-50, -90)
	plat_instance.position.y = random_y_position
