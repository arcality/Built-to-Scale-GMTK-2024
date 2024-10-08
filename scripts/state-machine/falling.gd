extends State

var player : Player
var speed : float

# to make sure that state is not immediately left if that is not intended
var timer : float
# not currently needed

func Enter():
	player = owner
	speed = player.speed
	timer = 0.0
	player.clinging_direction = 0.0
	
	
	
func Update(delta:float):
	# player can control position in air
	
	
	var horizontal_direction = player.horizontal_movement_direction()
	player.target_velocity = horizontal_direction * speed * delta
	
	if player.is_on_floor():
		state_transition.emit(self, "idle")
		print("transition to idle")
		if Input.is_action_just_pressed("jump"):
			force_transition.emit("jumping")
			print("force jumping")
		
	if player.velocity.y < 0: # going up
		player.gravity = 2000
		player.acceleration_amount = 40
		player.deceleration_amount = 200
	else: # going down
		player.gravity = 2300
		player.acceleration_amount = 75
		player.deceleration_amount = 200
	
	# checks if the player is touching a wall and falling down
	if player.is_on_wall() and player.velocity.y > 0 and player.active_arm_state != "jumpboosting":
		if Input.is_action_pressed("move_right") and $"../../RayCastRight".is_colliding():
			state_transition.emit(self, "clinging")
			print("transition to clinging")
			player.clinging_direction = 1.0
				
		if Input.is_action_pressed("move_left") and $"../../RayCastLeft".is_colliding():
			state_transition.emit(self, "clinging")
			print("transition to clinging")
			player.clinging_direction = -1.0
			
		if (Input.is_action_just_pressed("jump") or player.jump_buffer > 0.0) and player.active_arm_state == "walljumping":
			force_transition.emit("walljumping")
			print("force wall jumping")
			
	if player.is_on_wall() and player.horizontal_movement_direction() != 0.0:
		if (Input.is_action_just_pressed("jump") or player.jump_buffer > 0.0) and player.active_arm_state == "walljumping":
				force_transition.emit("walljumping")
				print("force wall jumping")
	
	# checks for climbing coyote time before using up special jump
	if player.climb_coyote_time > 0.0 and Input.is_action_just_pressed("jump") and player.active_arm_state == "walljumping":
		state_transition.emit(self, "walljumping")
		print("coyote wall jump")
	elif not player.special_jump_used and Input.is_action_just_pressed("jump"):
		player.special_jump_used = true
		state_transition.emit(self, player.active_jetpack_state)
		print("transition to special jump from falling")
	
	if Input.is_action_just_pressed("jump") and !player.is_on_floor() and !player.is_on_wall():
		player.jump_buffer = 0.06
		
	
	
	
	timer += 0.01

