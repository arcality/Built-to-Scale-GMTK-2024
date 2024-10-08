extends State

var player : Player

var timer := 0.0

func Enter():
	# sets player to root of scene
	player = owner
	player.special_jump_used = false
	
	#player.target_velocity = 0
	player.acceleration_amount = 75
	player.deceleration_amount = 300
	

func Exit():
	pass

func Update(_delta):
	
	if timer > 0.1:
		player.target_velocity = 0
		
	
	if player.horizontal_movement_direction() != 0:
		state_transition.emit(self, "running")
		print("transition to running")
		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			#if player.is_on_floor() and player.active_arm_state == "jumpboosting":
				#player.velocity.y = player.jump_strength * 1.7
			#else:
				#player.velocity.y = player.jump_strength
			force_transition.emit("jumping")
			print("jump while running safeguard")
	
	if (Input.is_action_just_pressed("jump") or player.jump_buffer > 0.0) and player.is_on_floor():
		state_transition.emit(self, "jumping")
		print("transition to jumping from idle")
	
	if not player.is_on_floor():
		state_transition.emit(self, "falling")
		print("transition to falling")
	
	timer += 0.01
	


