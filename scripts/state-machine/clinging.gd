extends State

var player : Player

var wall_direction = 0
# doesn't work yet

func Enter():
	player = owner
	player.special_jump_used = false
	player.gravity = 0
	player.velocity.y = 0
	wall_direction = player.movement_direction()
	

func Exit():
	player.gravity = 2000
	#print(player.gravity)

func Update(_delta:float):
	if player.movement_direction() == 0:
		state_transition.emit(self, "falling")
	
	
	
