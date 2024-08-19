extends State

var player : Player

func Enter():
	player = owner
	player.velocity.y = player.jump_strength
	if $"../../RayCastRight".is_colliding():
		player.velocity.x = -2000
	elif $"../../RayCastLeft".is_colliding():
		player.velocity.x = 2000
	else:
		print("too far away")
		
	
func Update(delta:float):
	state_transition.emit(self, "falling")
	print("transition to falling")
