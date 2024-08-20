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

# ROBOT ANIMATIONS
@onready var robot = $CompositeSprites/Robot
# JETPACK ANIMATIONS
@onready var dashing = $CompositeSprites/Jetpacks/dashing
@onready var doublejumping = $CompositeSprites/Jetpacks/jumping
@onready var umbrellaing = $CompositeSprites/Jetpacks/umbrellaing
# ARM ANIMATIONS
@onready var walljumping = $CompositeSprites/Arms/walljumping
@onready var climbing = $CompositeSprites/Arms/climbing
@onready var jumpboosting = $CompositeSprites/Arms/jumpboosting

var target_velocity : float
var acceleration_amount: float
var deceleration_amount: float

@export var active_jetpack_state : String
var current_jetpack_anim : AnimatedSprite2D
# can be "jumping" or "dashing" or (WIP) "umbrellaing"

@export var active_arm_state : String
var current_arm_anim : AnimatedSprite2D
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
	
	# gravity processing
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# stores a facing direction that is never zero/equal to the last direction
	# input (mainly for dashing)
	if horizontal_movement_direction() != 0:
		facing_direction = horizontal_movement_direction()
	
	# check what current jetpack state is
	if active_jetpack_state != "" and active_jetpack_state != null:
		if active_jetpack_state == "dashing":
			umbrellaing.visible = false
			doublejumping.visible = false
			dashing.visible = true
			current_jetpack_anim = dashing
		elif active_jetpack_state == "jumping":
			umbrellaing.visible = false
			doublejumping.visible = true
			dashing.visible = false
			current_jetpack_anim = doublejumping
		elif active_jetpack_state == "umbrellaing":
			umbrellaing.visible = true
			doublejumping.visible = false
			dashing.visible = false
			current_jetpack_anim = umbrellaing
		print(" ------ " + active_jetpack_state)
		print(current_jetpack_anim)
	# check what current arm state is
	if active_arm_state != "" and active_arm_state != null:
		if active_arm_state == "jumpboosting":
			walljumping.visible = false
			climbing.visible = false
			jumpboosting.visible = true
			current_arm_anim = dashing
		elif active_arm_state == "climbing":
			walljumping.visible = false
			climbing.visible = true
			jumpboosting.visible = false
			current_arm_anim = doublejumping
		elif active_arm_state == "walljumping":
			walljumping.visible = true
			climbing.visible = false
			jumpboosting.visible = false
			current_arm_anim = umbrellaing
		print(" ------ " + active_arm_state)
		print(current_arm_anim)
	
	# Flip the sprite
	if facing_direction > 0:
		robot.flip_h = false
		if current_arm_anim != null:
			current_arm_anim.flip_h = false
		if current_jetpack_anim != null:
			current_jetpack_anim.flip_h = false
		
	elif facing_direction < 0:
		robot.flip_h = true
		if current_arm_anim != null:
			current_arm_anim.flip_h = true
		if current_jetpack_anim != null:
			current_jetpack_anim.flip_h = true
	
	# play sprite animations
	#if horizontal_movement_direction() == 0:
		#robot.play("idle")
	#else:
		#robot.play("running")
	
	if $FiniteStateMachine.current_state.name.to_lower() in robot.sprite_frames.get_animation_names():
		#print($FiniteStateMachine.current_state.name.to_lower())
		if current_arm_anim != null:
			current_arm_anim.play($FiniteStateMachine.current_state.name.to_lower())
		if current_jetpack_anim != null:
			current_jetpack_anim.play($FiniteStateMachine.current_state.name.to_lower())
		
		robot.play($FiniteStateMachine.current_state.name.to_lower())
	else:
		robot.play("idle")
	
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
	
	

# setting active_arm_state when changed in edit menu
func _on_edit_menu_arm_selected(arm_type):
	# NULL CHECK IF BUTTON IS DESELECTED
	if arm_type != null:
		active_arm_state = arm_type.name
	else:
		# if no ability selected, set active_arm_state to empty string
		active_arm_state = ""
	print(" ------ " + active_arm_state)

# setting active_jetpack_state when changed in edit menu
func _on_edit_menu_jetpack_selected(jetpack_type):
	if jetpack_type != null:
		active_jetpack_state = jetpack_type.name
	else:
		# if no ability selected, set active_jetpack_state to empty string
		active_jetpack_state = ""
	print(" ------ " + active_jetpack_state)
