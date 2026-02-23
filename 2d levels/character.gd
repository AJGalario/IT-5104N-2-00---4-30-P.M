extends CharacterBody2D

@export var base_speed : float = 200.0
@export var max_speed : float = 500.0
@export var acceleration_rate : float = 5.0

@export var jump_velocity : float = -400.0
@export var gravity : float = 900.0
const health = 1

var current_speed : float

func die():
	call_deferred("_reload_scene")
func _ready():
	current_speed = base_speed

func _physics_process(delta):

	if not is_on_floor():
		velocity.y += gravity * delta
		die()

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * base_speed
	else:
		velocity.x = move_toward(velocity.x, 0, base_speed)

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	move_and_slide()
