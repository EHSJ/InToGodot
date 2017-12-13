# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends CanvasLayer

export var texto = ""

func _ready():
	get_node( "InfoPosicion/Panel/Label" ).set_text( texto )
