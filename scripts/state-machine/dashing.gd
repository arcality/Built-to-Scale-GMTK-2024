extends State

var player : Player

var dash_speed = 1000

func Enter():
	player = owner
	player.velocity.x = dash_speed * player.facing_direction
	$Timer.start()
	
func Update(_delta:float):
	# generate particles or smth
	pass
	


func _on_timer_timeout():
	state_transition.emit(self, "falling")
	print("transition to falling")
