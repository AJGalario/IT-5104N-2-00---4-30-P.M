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
	HUD.update_deaths(Global.deaths)
	if backgroundmusic:
		musicAudioBG.play()

	var player = $Character
	player.base_speed = 200
	player.max_speed = 300
	player.acceleration_rate = 5
	player.jump_velocity = -500
	player.gravity = 900

	HUD.set_label_color(Color.BLACK)


func _on_to_lvl_2_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		get_tree().change_scene_to_file("res://levels/level_2.tscn")


func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		body.die()
