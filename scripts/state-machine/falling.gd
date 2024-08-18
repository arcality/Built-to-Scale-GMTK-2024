extends State

var player : Player
var speed : float

func Enter():
	player = owner
	speed = player.speed
	
func Update(delta:float):
	# player can control position in air
	var horizontal_direction = player.movement_direction()
	player.velocity.x = horizontal_direction * speed * delta
	
	if player.is_on_floor():
		state_transition.emit(self, "idle")
		print("transition to idle")
	
	# checks if the player is touching a wall and falling down
	if player.is_on_wall() and player.velocity.y > 0:
		state_transition.emit(self, "clinging")
		print("transition to clinging")
	# this might now work yet
	
	if not player.special_jump_used and Input.is_action_just_pressed("jump"):
		player.special_jump_used = true
		state_transition.emit(self, player.active_jetpack_state)
		print("transition to jumping from falling")

