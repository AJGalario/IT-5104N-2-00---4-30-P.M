extends Node2D

func _ready():
  	var player = $Character# adjust the path to your Player node
 	player.base_speed = 100
	player.max_speed = 500
	player.acceleration_rate = 5
	player.jump_velocity = -500
	player.gravity = 900

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		body.position = Vector2(135, 466) # starting position
