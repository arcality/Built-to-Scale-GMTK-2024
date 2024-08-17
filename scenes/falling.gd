extends State

var player : Player
var speed : float

var jump_strength = -600

func Enter():
	player = owner
	speed = player.speed
	
func Update(delta:float):
	var horizontal_direction = player.movement_direction()
	player.velocity.x = horizontal_direction * speed * delta
	
	if player.is_on_floor():
		state_transition.emit(self, "idle")
		print("transition to idle")

