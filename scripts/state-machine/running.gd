extends State

var player : Player
var speed : float

func Enter():
	# stores the parent player node as "player"
	player = owner
	
	# since different runs might have different speeds, i am setting the player 
	# speed here.
	# this way the other states can access the player's speed without needing 
	# to know which running state is being used by the robot
	player.speed = 20000
	speed = player.speed
	
	player.acceleration_amount = 75
	player.deceleration_amount = 200


func Exit():
	pass

func Update(delta:float):
	# directly changes horizontal velocity depending on left/right directional 
	# keys
	var horizontal_direction = player.horizontal_movement_direction()
	player.target_velocity = horizontal_direction * speed * delta
	
	if horizontal_direction == 0:
		state_transition.emit(self, "idle")
		print("transition to idle")
	
	if Input.is_action_just_pressed("jump") and player.is_on_floor():
		state_transition.emit(self, "jumping")
		print("transition to jumping")
		
	if not player.is_on_floor():
		state_transition.emit(self, "falling")
		print("transition to falling")
	
	if player.is_on_wall() and player.vertical_movement_direction() != 0 and player.active_arm_state == "climbing":
		if Input.is_action_pressed("move_right") and $"../../RayCastRight".is_colliding():
			state_transition.emit(self, "clinging")
			print("transition to clinging")
			player.clinging_direction = 1.0
		if Input.is_action_pressed("move_left") and $"../../RayCastLeft".is_colliding():
			state_transition.emit(self, "clinging")
			print("transition to clinging")
			player.clinging_direction = -1.0
