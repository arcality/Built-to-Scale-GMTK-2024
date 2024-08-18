extends State

var player : Player
var speed : float

# to make sure that state is not immediately left if that is not intended
var timer : float

func Enter():
	player = owner
	speed = player.speed
	timer = 0.0
	
func Update(delta:float):
	# player can control position in air
	var horizontal_direction = player.movement_direction()
	player.velocity.x = horizontal_direction * speed * delta
	
	if player.is_on_floor():
		state_transition.emit(self, "idle")
		print("transition to idle")
	
	# checks if the player is touching a wall and falling down and account for buffer
	if player.is_on_wall() and player.velocity.y > 0 and timer > 0.1:
		if Input.is_action_pressed("move_right") and $"../../RayCastRight".is_colliding():
			state_transition.emit(self, "clinging")
			print("transition to clinging")
			player.clinging_direction = 1.0
		if Input.is_action_pressed("move_left") and $"../../RayCastLeft".is_colliding():
			state_transition.emit(self, "clinging")
			print("transition to clinging")
			player.clinging_direction = -1.0
	
	if not player.special_jump_used and Input.is_action_just_pressed("jump") and timer > 0.1:
		player.special_jump_used = true
		state_transition.emit(self, player.active_jetpack_state)
		print("transition to jumping from falling")
	
	timer += 0.01

