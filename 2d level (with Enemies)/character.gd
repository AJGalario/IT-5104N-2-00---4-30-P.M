extends CharacterBody2D

@onready var walk_player = $Walking
@onready var jump_player = $Jumping

@export var base_speed : float = 200.0
@export var max_speed : float = 500.0
@export var acceleration_rate : float = 5.0
@export var jump_velocity : float = -400.0
@export var gravity : float = 900.0

var hp : int = 100
var max_hp : int = 100
var current_speed : float

var metal_walk = preload("res://music/player sfx/Screen Recording 2026-02-27 162549 - Trim.mp3")
var tile_walk  = preload("res://music/player sfx/picture walk.mp3")


func take_damage(amount: int) -> void:
	hp = clamp(hp - amount, 0, max_hp)
	HUD.update_health(hp, max_hp)
	if hp == 0:
		die()

func die() -> void:
	Global.deaths += 1
	HUD.update_deaths(Global.deaths)
	hp = max_hp
	HUD.update_health(max_hp, max_hp)
	position = Vector2(135, 466)
func _ready() -> void:
	current_speed = base_speed
	HUD.update_health(hp, max_hp)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	var speed = max_speed if Input.is_key_pressed(KEY_SHIFT) else base_speed

	if direction != 0:
		velocity.x = direction * speed
		if is_on_floor():
			if not walk_player.playing:
				walk_player.stream = metal_walk
				walk_player.play()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if walk_player.playing:
			walk_player.stop()

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		jump_player.play()

	move_and_slide()
