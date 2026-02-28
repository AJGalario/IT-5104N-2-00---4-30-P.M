extends CharacterBody2D

@onready var main = $"/root/main"
@onready var walk_player = $Walking
@onready var jump_player = $Jumping

@export var base_speed : float = 200.0
@export var max_speed : float = 500.0
@export var acceleration_rate : float = 5.0

@export var jump_velocity : float = -400.0
@export var gravity : float = 900.0
const health = 1
var hp     : int = 100
var max_hp : int = 100
var current_speed : float

func take_damage(amount: int) -> void:
	hp = clamp(hp - amount, 0, max_hp)
	main.hud.update_health(hp, max_hp)
	if hp == 0:
		die()
func die() -> void:
	main.on_player_death()
	main.hud.update_health(max_hp, max_hp)  # reset bar on respawn
	hp = max_hp
	position = Vector2(135, 466)
	

func _ready():
	current_speed = base_speed

func _physics_process(delta):
	var metal_walk = load("res://music/player sfx/Screen Recording 2026-02-27 162549 - Trim.mp3")
	var tile_walk = load("res://music/player sfx/picture walk.mp3")
	if not is_on_floor():
		velocity.y += gravity * delta

	var direction := Input.get_axis("ui_left", "ui_right")
	var run = Input.is_key_pressed(KEY_SHIFT)
	var speed = max_speed if run else base_speed
	if direction != 0:
		velocity.x = direction * speed
		if is_on_floor():
			if !walk_player.playing:
				walk_player.stream = (metal_walk)
				walk_player.play()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		walk_player.stop()
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity
		jump_player.play()
	move_and_slide()
