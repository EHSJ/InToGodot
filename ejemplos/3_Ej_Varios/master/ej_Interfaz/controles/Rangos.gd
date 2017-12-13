# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Control

onready var hSlider = get_node("VBoxContainer/HSlider")
onready var barra = get_node("VBoxContainer/ProgressBar")
onready var scroll = get_node("VBoxContainer/HScrollBar")
onready var spin = get_node("SpinBox")

func cambio ( nuevo ):
	hSlider.set_value( nuevo )
	barra.set_value( nuevo )
	scroll.set_value( nuevo )
	spin.set_value( nuevo )


