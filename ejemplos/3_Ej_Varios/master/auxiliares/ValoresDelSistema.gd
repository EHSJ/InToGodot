# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Node

func _ready():
	print(OS.get_date())
	print(OS.can_use_threads())
	print(OS.get_engine_version())
	print(OS.get_model_name())
	print(OS.get_name())
	print(OS.get_process_ID())
	print(OS.get_processor_count())
	print(OS.get_screen_count())
	print(OS.get_screen_dpi())
	print(OS.get_screen_orientation())
	print(OS.get_screen_position())
	print(OS.get_screen_size())
	print(OS.has_touchscreen_ui_hint())z
	print(OS.has_virtual_keyboard())

	get_tree().quit()

func cpuInfo():
	pass
