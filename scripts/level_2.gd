extends Node2D

func _ready():
	var player = $Character  # adjust the path to your Player node
	
	player.base_speed = 150
	player.max_speed = 200
	player.acceleration_rate = 3
	player.jump_velocity = -500
	player.gravity = 900

func _on_to_lvl_3_body_entered(body: Node) -> void:
	# Change to level 3 scene when the body enters the trigger
	get_tree().change_scene_to_file("res://levels/level_3.tscn")
	
func _on_death_body_entered(body: Node) -> void:
	# If the colliding body is the player, reset its position
	if body.name == "Character":
		body.position = Vector2(135, 466)  # starting position
