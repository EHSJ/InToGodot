# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Node

func _ready():
	get_viewport().connect("size_changed",self,"cambioTam")

func cambioTam():
	print(OS.get_video_mode_size(0),OS.get_window_size())
