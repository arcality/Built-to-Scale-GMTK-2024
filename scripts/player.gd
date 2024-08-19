extends CharacterBody2D
class_name Player # so that autocompletion partially works

var spawn_position : Vector2

var gravity := 2000.0
var speed := 20000.0
var jump_strength := -600.0
var special_jump_used := false
var facing_direction := 1.0 # for dashing
var clinging_direction := 0.0

var climb_coyote_time := 0.0
var jump_buffer := 0.0

var target_velocity : float
var acceleration_amount: float
var deceleration_amount: float

@export var active_jetpack_state : String
# can be "jumping" or "dashing" or (WIP) "umbrellaing"

@export var active_arm_state : String
# doesn't quite have same functionality as active_jetpack_state, but is still
# being used to keep track of arms
#
# can be "climbing" "walljumping" or (not on a script) "jumpboosting" 
# 

# DISREGARD THIS
# maybe i can signal from the states to here, and determine which action to switch to
# depending on the current abilities
# for example, while in the jumping state, I can send a signal to the player class,
# saying that I am pressing the jumping button, and then the player class can determine
# whether or not to transition to the airdash or doublejump state, depending on
# the equipped ability

# MAYBE COME BACK TO THIS
# maybe I should have all of the state transition code in here, so that the states
# themselves do not need to worry about that
# however, state changes may be dependent on which state the player is currently in,
# so it could be easier to change to a state from the state itself

# ** USING THIS ** active_jetpack_state
# i could have a variable in the player class that corresponds with the name of
# a state, and when a button, such as jump, is pressed, the current state switches to
# that state, accessing a single location whose value is determined by the player class

# Called when the node enters the scene tree for the first time.
func _ready():
	#active_jetpack_state = "dashing"
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# stores a facing direction that is never zero/equal to the last direction
	# input (mainly for dashing)
	if horizontal_movement_direction() != 0:
		facing_direction = horizontal_movement_direction()
	
	# if current velocity is to the right
	if velocity.x > 0:
		# if target velocity is greater than current velocity (acceleration)
		if velocity.x < target_velocity:
			velocity.x = move_toward(velocity.x, target_velocity, acceleration_amount)
		# if target velocity is less than current velocity (deceleration)
		if velocity.x > target_velocity:
			velocity.x = move_toward(velocity.x, target_velocity, deceleration_amount)
	# if current velocity is to the right
	elif velocity.x < 0:
		# if target velocity is less than current velocity (acceleration)
		if velocity.x > target_velocity:
			velocity.x = move_toward(velocity.x, target_velocity, acceleration_amount)
		# if target velocity is greater than current velocity (deceleration)
		if velocity.x < target_velocity:
			velocity.x = move_toward(velocity.x, target_velocity, deceleration_amount)
	elif velocity.x == 0:
		velocity.x = move_toward(velocity.x, target_velocity, acceleration_amount)
	
	#print(velocity.x)
	#if velocity.x == 0.0 and not is_on_floor():
		#print("stopped")
	
	#print(gravity)
	#print(clinging_direction)
	#if climb_coyote_time > 0.0:
		#print(climb_coyote_time)
		
	if jump_buffer > 0.0:
		print(jump_buffer)
	
	climb_coyote_time -=0.01
	jump_buffer -= 0.01
	
	move_and_slide()

# old functionality that is still used, but should be replaced with
# Input.is_action_just_pressed() in scripts that use this
func trying_jump() -> bool:
	if Input.is_action_pressed("jump"):
		return true
	return false

# returns the movement direction
func horizontal_movement_direction() -> float:
	return Input.get_axis("move_left", "move_right")

func vertical_movement_direction() -> float:
	return Input.get_axis("move_up", "move_down")
	
	
