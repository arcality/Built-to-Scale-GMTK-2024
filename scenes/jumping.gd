extends State

var player : Player
var speed : float

var jump_strength = -600

func Enter():
	player = owner
	player.velocity.y = jump_strength
	
func Update(delta:float):
	state_transition.emit(self, "falling")
	print("transition to falling")
