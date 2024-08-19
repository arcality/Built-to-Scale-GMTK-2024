extends Control

@export var arm_group: ButtonGroup
signal toggled(toggled_on: bool)

func _ready():
	# running the button_pressed() function whenever a button is pressed
	for i in arm_group.get_buttons():
		i.toggled.connect(button_toggled)
	print(arm_group.get_buttons())

func button_toggled(toggled_on: bool):
	print(arm_group.get_pressed_button())
	print(toggled_on)
