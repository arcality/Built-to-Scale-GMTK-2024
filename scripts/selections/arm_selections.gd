extends Control

# mutually exclusive button group
@export var arm_group: ButtonGroup
signal toggled(toggled_on: bool)
signal arm_selected(arm_type: Button)

func _ready():
	# running the button_pressed() function whenever a button is pressed
	for i in arm_group.get_buttons():
		i.toggled.connect(button_toggled)
	print(arm_group.get_buttons())

# send signal that button has been toggled up
func button_toggled(toggled_on: bool):
	#if arm_group.get_pressed_button() != null && toggled_on:
		#print(arm_group.get_pressed_button().name)
	#elif arm_group.get_pressed_button() == null:
		#print(arm_group.get_pressed_button())
	
	# emit which ability is selected when it is on
	if toggled_on:
		arm_selected.emit(arm_group.get_pressed_button())
