# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Control

onready var luz = get_node( "Luz" )
onready var oclusorScn = load( "res://ej_Node2D/iluminacion2D/oclusor.tscn" )

var mover = false
var puedePoner = true
var modo = 0

func _ready():
	cambiaModo()
	set_process_input( true )

func _input(event):
	# Evento de Botón del Ratón.
	if (event.type == InputEvent.MOUSE_BUTTON):
		if (event.button_index == BUTTON_WHEEL_DOWN):
			if(Input.is_mouse_button_pressed(BUTTON_WHEEL_DOWN)):
				if modo > 0 : modo -= 1
				cambiaModo()
		if (event.button_index == BUTTON_WHEEL_UP):
			if(Input.is_mouse_button_pressed(BUTTON_WHEEL_UP)):
				if modo < 3 : modo += 1
				cambiaModo()
		if (event.button_index == BUTTON_RIGHT):
			if(Input.is_mouse_button_pressed(BUTTON_RIGHT)):
				mover = true
				luz.set_pos(  get_global_mouse_pos() )
			else:
				mover = false
		if (event.button_index == BUTTON_LEFT):
			if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
				if ( puedePoner ):
					var oclusor = oclusorScn.instance()
					get_node( "Oclusores" ).add_child( oclusor )
					oclusor.set_pos( get_global_mouse_pos() )
					puedePoner = false
			else:
				puedePoner = true

	# Evento de Movimiento del Ratón.
	if (event.type == InputEvent.MOUSE_MOTION):
		# Si está en modo desplazamiento.
		if(mover == true):
			luz.set_pos(  get_global_mouse_pos() )

func cambiaModo():
	luz.get_node( "Light2D" ).set_mode( modo )
	var texto = ""
	if modo == 0: texto = "Añadir."
	if modo == 1: texto = "Restar."
	if modo == 2: texto = "Mezclar."
	if modo == 3: texto = "Máscara."

	get_node( "efecto" ).set_text( "Modo de iluminación: " + texto )
