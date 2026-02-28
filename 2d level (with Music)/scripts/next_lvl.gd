extends Node2D

@onready var musicAudioBG = $"Background Music"
@onready var label = $Label
var backgroundmusic = true

	
func set_music(enabled: bool) -> void:
	backgroundmusic = enabled
	if backgroundmusic:
		musicAudioBG.play()
	else:
		musicAudioBG.stop()
		
func _ready():
	
	label.add_theme_color_override("font_color", Color.WHITE)
	label.add_theme_constant_override("outline_size", 3)
	label.add_theme_color_override("font_outline_color", Color.BLACK)
	
	if backgroundmusic:
		musicAudioBG.play()
	var player = $Character # adjust the path to your Player node
	player.base_speed = 200
	player.max_speed = 300
	player.acceleration_rate = 5
	player.jump_velocity = -500
	player.gravity = 900


func _on_to_lvl_2_body_entered(body: Node2D) -> void:
	get_tree().change_scene_to_file("res://levels/level_2.tscn")


func _on_death_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		body.position = Vector2(135, 466) # starting position
		Global.deaths += 1
