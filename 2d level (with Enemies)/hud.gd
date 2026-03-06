extends CanvasLayer

@onready var health_bar   : ProgressBar = $HBoxContainer/VBoxContainer/BarHealth
@onready var health_label : Label       = $HBoxContainer/VBoxContainer/LabelHealth
@onready var death_label  : Label       = $HBoxContainer/VBoxContainer/LabelDeath

func _ready() -> void:
	add_to_group("hud")
	health_bar.min_value = 0
	health_bar.max_value = 100
	health_bar.value     = 100
	health_label.text    = "Health Points" 
	death_label.text     = "DEATHS: 0"

func update_health(current: int, maximum: int) -> void:
	health_bar.max_value = maximum
	health_bar.value     = current
	health_label.text    = "%d" % current

func update_deaths(count: int) -> void:
	death_label.text = "DEATHS: %d" % count

func set_label_color(color: Color) -> void:
	health_label.add_theme_color_override("font_color", color)
	death_label.add_theme_color_override("font_color", color)
