extends State

var player : Player
var speed : float

# doesn't work yet

func Enter():
	player = owner
	player.special_jump_used = false
	player.gravity = 0
	player.velocity.y = 0
	

func Exit():
	player.gravity = 2000

func Update(delta : float):
	var horizontal_direction = player.movement_direction()
	player.velocity.x = horizontal_direction * speed * delta
	
	# clinging to running
	if player.movement_direction() != 0:
		state_transition.emit(self, "running")
		print("transition to running from clinging")
	
	# clinging to jumping (WORKS ONLY ON GROUND)
	if player.trying_jump() and player.is_on_floor():
		state_transition.emit(self, "jumping")
		print("transition to jumping from clinging")
	
	# clinging to falling
	if not player.is_on_floor() and not player.is_on_wall():
		state_transition.emit(self, "falling")
		print("transition to falling from clinging")
	
