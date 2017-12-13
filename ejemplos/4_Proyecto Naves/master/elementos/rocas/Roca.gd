# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends RigidBody2D

var vida

func _ready():
	vida = 16

func impacto( poder ):
	vida -= poder
	if ( vida <=0 ):
		# dividirse o morir
		self.queue_free()
