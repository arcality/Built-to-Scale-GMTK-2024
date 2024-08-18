extends State

var player : Player

# executed quickly before transitioning to falling

func Enter():
	player = owner
	player.velocity.y = player.jump_strength
	
func Update(_delta : float):
	state_transition.emit(self, "falling")
	print("transition to falling")
