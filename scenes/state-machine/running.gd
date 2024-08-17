extends State

var player : Player
var speed : float

func Enter():
	# stores the parent player node as "player"
	player = owner
	
	# since different runs might have different speeds, i am setting the player speed here.
	# this way the jumping and falling states can access the player's speed without needing
	# to access which running state is being used by the robot
	player.speed = 10000
	speed = player.speed
	

func Exit():
	pass

func Update(delta:float):
	# directly changes horizontal velocity depending on left/right directional keys
	var horizontal_direction = player.movement_direction()
	player.velocity.x = horizontal_direction * speed * delta
	
	if horizontal_direction == 0:
		state_transition.emit(self, "idle")
		print("transition to idle")
	
	if player.trying_jump() and player.is_on_floor():
		state_transition.emit(self, "jumping")
		print("transition to jumping")
