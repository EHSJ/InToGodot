# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Node


func _ready():
	OS.set_low_processor_usage_mode(true)
	OS.set_window_maximized(true)

func romanos(numero):
	if(numero==1):return "I"
	elif(numero==2):return "II"
	elif(numero==3):return "III"
	elif(numero==4):return "IV"
	elif(numero==5):return "V"
