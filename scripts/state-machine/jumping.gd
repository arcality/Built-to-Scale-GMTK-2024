extends State

var player : Player

# executed quickly before transitioning to falling

func Enter():
	player = owner
	if player.is_on_floor() and player.active_arm_state == "jumpboosting":
		player.velocity.y = player.jump_strength * 1.7
	else:
		player.velocity.y = player.jump_strength
	
func Update(delta:float):
	state_transition.emit(self, "falling")
	print("transition to falling")
