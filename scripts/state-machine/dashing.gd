extends State

var player : Player

var dash_speed = 3000

func Enter():
	player = owner
	player.velocity.x = dash_speed * player.facing_direction
	#$Timer.start()
	
func Update(_delta:float):
	#if player.is_on_wall():
		#$Timer.stop()
	state_transition.emit(self, "falling")
	print("transition to falling")
	


#func _on_timer_timeout():
	#state_transition.emit(self, "falling")
	#print("transition to falling")
	#print("Timer timeout")
