extends Node2D

@onready var hud = $CanvasLayer

var score  : int = 0
var deaths : int = 0

func _ready() -> void:
	hud.update_deaths(deaths)

func on_player_death() -> void:
	deaths += 1
	hud.update_deaths(deaths)
