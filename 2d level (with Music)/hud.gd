extends CanvasLayer

@onready var health_bar   : ProgressBar = $HBoxContainer/VBoxContainer/HealthBar
@onready var health_label : Label       = $HBoxContainer/VBoxContainer/Health
@onready var score_label  : Label       = $HBoxContainer/VBoxContainer/Score
@onready var death_label  : Label       = $HBoxContainer/VBoxContainer/DeathCount

func _process(_delta: float) -> void:
	death_label.text = "DEATHS: %d" % Global.deaths

func _ready() -> void:
	health_bar.min_value = 0
	health_bar.max_value = 100
	health_bar.value     = 100
	health_label.text    = "HP"
	death_label.text     = "DEATHS"

func update_health(current: int, maximum: int) -> void:
	health_bar.value  = current
	health_label.text = "HP: %d / %d" % [current, maximum]

func update_deaths(deaths: int) -> void:
	death_label.text = "DEATHS: %d" % deaths
