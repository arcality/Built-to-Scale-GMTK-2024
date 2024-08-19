extends Control

@onready var main = $"../../"

func _on_resume_pressed():
	main.editMenu()
