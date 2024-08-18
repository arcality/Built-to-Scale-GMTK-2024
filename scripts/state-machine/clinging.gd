extends State

var player : Player

# if you let go slightly before you jump, you can still jump
var buffer_timer := 0.0

func Enter():
	player = owner
	
	# reset doublejump
	player.special_jump_used = false
	
	# stops falling
	player.gravity = 0
	player.velocity.y = 0
	

func Exit():
	# re-enables falling
	#player.gravity = 2000
	#print(player.gravity)
	pass

func Update(_delta:float):
	
	# starts jump buffer timer after letting go, and allows gravity 
	if player.horizontal_movement_direction() != player.clinging_direction:
		buffer_timer += 0.01
		player.gravity = 2000
	else:
		buffer_timer = 0.0
		player.gravity = 0
		player.velocity.y = 0
		
	if buffer_timer > 0.06:
		state_transition.emit(self, "falling")
		print("transition to falling")
	
	if player.vertical_movement_direction() != 0 and player.active_arm_state == "climbing":
		state_transition.emit(self, "climbing")
		print("transition to climbing")
	
	if Input.is_action_just_pressed("jump") and player.active_arm_state == "walljumping":
		state_transition.emit(self, "walljumping")
		print("transition to walljumping")
		
	
	
