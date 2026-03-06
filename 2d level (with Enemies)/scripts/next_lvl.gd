extends Node2D

@onready var musicAudioBG = $"Background Music"
var backgroundmusic = true

func set_music(enabled: bool) -> void:
	backgroundmusic = enabled
	if backgroundmusic:
		musicAudioBG.play()
	else:
		musicAudioBG.stop()

func _ready() -> void:
	if backgroundmusic:
		musicAudioBG.play()

	var player = $Character
	player.base_speed = 200
	player.max_speed = 300
	player.acceleration_rate = 5
	player.jump_velocity = -500
	player.gravity = 900

	# Connect player signals to HUD
	var hud = get_tree().get_first_node_in_group("hud")
	if hud:
		player.health_changed.connect(hud._on_health_changed)
		player.death_occurred.connect(hud._on_death_occurred)
		hud.set_label_color(Color.BLACK)
		hud._on_health_changed(player.hp, player.max_hp)
		hud._on_death_occurred(player.deaths)

func _on_to_lvl_2_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		get_tree().change_scene_to_file("res://levels/level_2.tscn")

func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		body.die()
