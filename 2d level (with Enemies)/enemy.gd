extends CharacterBody2D

enum State { PATROL, ATTACK }

var state : State = State.PATROL

# Patrol settings
var patrol_speed   : float = 80.0
var patrol_range   : float = 150.0
var start_position : Vector2
var patrol_direction : float = 1.0

# Attack settings
var attack_speed   : float = 150.0
var attack_damage  : int   = 100
var attack_cooldown: float = 1.0
var attack_timer   : float = 0.0

# Gravity
var gravity : float = 900.0

# Player reference
var player : CharacterBody2D = null

func _ready() -> void:
	start_position = global_position

func _physics_process(delta: float) -> void:
	# Always apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta

	attack_timer -= delta

	match state:
		State.PATROL:
			_patrol(delta)
		State.ATTACK:
			_attack(delta)

	move_and_slide()

func _patrol(delta: float) -> void:
	velocity.x = patrol_speed * patrol_direction

	# Flip direction at patrol range limits
	var distance_from_start = global_position.x - start_position.x
	if distance_from_start > patrol_range:
		patrol_direction = -1.0
		$Sprite2D.flip_h = true
	elif distance_from_start < -patrol_range:
		patrol_direction = 1.0
		$Sprite2D.flip_h = false

	# Also flip at walls
	if is_on_wall():
		var collision = get_last_slide_collision()
		if collision and collision.get_collider() is TileMap:
			patrol_direction *= -1.0
			global_position.x += patrol_direction * 5.0

func _on_detection_body_entered(body: Node2D) -> void:
	if body.name == "Character":
		player = body
		state  = State.ATTACK
		
func _attack(delta: float) -> void:
	if player == null:
		state = State.PATROL
		return

	# Move toward player
	var direction = sign(player.global_position.x - global_position.x)
	velocity.x = attack_speed * direction
	$Sprite2D.flip_h = direction < 0
	
	var horizontal_dist = abs(player.global_position.x - global_position.x)
	var vertical_dist   = abs(player.global_position.y - global_position.y)
	
	if horizontal_dist < 50.0 and vertical_dist < 60.0 and attack_timer <= 0.0:
		player.take_damage(attack_damage)
		attack_timer = attack_cooldown

	# Deal damage when close enough
	var distance = global_position.distance_to(player.global_position)
	if distance < 40.0 and attack_timer <= 0.0:
		player.take_damage(attack_damage)
		attack_timer = attack_cooldown

func _on_detection_body_exited(body: Node2D) -> void:
	if body.name == "Character":
		player = null
		state  = State.PATROL
