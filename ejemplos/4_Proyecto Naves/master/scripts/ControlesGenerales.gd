# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Node

onready var menuPrincipal = load( "res://menuPrincipal/MenuPrincipal.tscn")
var menuActivo = false

func _ready():
	print(" ControlesGenerales cargados.")
	set_process_input(true)

func insertarMernu():
	get_tree().get_root().add_child(menuPrincipal.instance())

func capturaPantalla():
	print("Captura de pantalla.")
	get_viewport().queue_screen_capture()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var screenshot = get_viewport().get_screen_capture()
	screenshot.save_png("user://Captura.png")

func _input(event):
	# Evento de pulsación.
	if(event.is_pressed()):
		# Tecla ESC.
		if(Input.is_key_pressed(KEY_F12)):
			capturaPantalla()
		if(Input.is_key_pressed(KEY_ESCAPE)):
			# Salir del programa.
			get_tree().quit()
		if(Input.is_key_pressed(KEY_TAB)):
			if ( menuActivo ):
				menuActivo = false
				get_tree().get_root().get_node("MenuPrincipal").queue_free()
			else:
				menuActivo = true
				insertarMernu()
