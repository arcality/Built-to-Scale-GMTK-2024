extends State

var player: Player

const FLOAT_SPEED = 7000

func Enter():
	player = owner
	player.special_jump_used = false
	player.gravity = 0
	player.acceleration_amount = 10
	player.deceleration_amount = 200

func Update(delta:float):
	player.velocity.y = FLOAT_SPEED * delta
	
	var horizontal_direction = player.horizontal_movement_direction()
	player.target_velocity = horizontal_direction * player.speed * delta
	
	if Input.is_action_just_pressed("jump"):
		state_transition.emit(self, "falling")
		print("transition to falling")
	
	if player.is_on_floor():
		state_transition.emit(self, "falling")
		print("transition to falling")
	
