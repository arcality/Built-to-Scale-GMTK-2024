extends State

var player : Player

func Enter():
	# sets player to root of scene
	player = owner
	player.special_jump_used = false
	
	player.target_velocity = 0
	player.acceleration = 100
	player.deceleration = 200

func Exit():
	pass

func Update(_delta):
	if player.horizontal_movement_direction() != 0:
		state_transition.emit(self, "running")
		print("transition to running")
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		state_transition.emit(self, "jumping")
		print("transition to jumping from idle")
	
	if not player.is_on_floor():
		state_transition.emit(self, "falling")
		print("transition to falling")
	


