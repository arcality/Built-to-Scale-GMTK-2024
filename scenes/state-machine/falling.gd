extends State

var player : Player
var speed : float

func Enter():
	player = owner
	speed = player.speed
	
func Update(delta:float):
	var horizontal_direction = player.movement_direction()
	player.velocity.x = horizontal_direction * speed * delta
	
	if player.is_on_floor():
		state_transition.emit(self, "idle")
		print("transition to idle")
	
	if not player.special_jump_used and Input.is_action_just_pressed("jump"):
		player.special_jump_used = true
		state_transition.emit(self, player.active_jetpack_state)
		print("transition to jumping from falling")

