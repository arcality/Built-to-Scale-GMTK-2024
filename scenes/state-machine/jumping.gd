extends State

var player : Player

func Enter():
	player = owner
	player.velocity.y = player.jump_strength
	
func Update(delta:float):
	state_transition.emit(self, "falling")
	print("transition to falling")
