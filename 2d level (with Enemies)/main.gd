extends Node2D

func _ready() -> void:
	HUD.update_deaths(Global.deaths)
