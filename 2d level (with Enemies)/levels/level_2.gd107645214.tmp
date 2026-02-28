extends Node2D

func _ready():
	var player = $Character  # adjust the path to your Player node
	player.base_speed = 130
	player.max_speed = 200
	player.acceleration_rate = 3
	player.jump_velocity = -900
	player.gravity = 900


func _on_to_lvl_3_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://levels/level_3.tscn")
