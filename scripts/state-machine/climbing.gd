extends State

var player : Player
var speed = 30000

func Enter():
	player = owner
	

func Update(delta:float):
	
	if player.horizontal_movement_direction() != player.clinging_direction:
		state_transition.emit(self, "clinging")
		print("transition to clinging")
	
	if not player.is_on_wall():
		state_transition.emit(self, "falling")
		print("transition to falling")
	
	player.velocity.y = player.vertical_movement_direction() * speed * delta
	#print(player.velocity.y)
