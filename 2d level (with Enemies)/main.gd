extends Node2D

func _ready() -> void:
	var player = get_tree().get_first_node_in_group("player")
	if player:
		player.death_occurred.connect(_on_death_occurred)

func _on_death_occurred(total_deaths: int) -> void:
	# deaths are now handled entirely by the HUD via signal
	pass
