# Introducción a Godot.
# CamioResolucion.gd
# Ejemplo de cambio de resoluciones.
# E.H.S.J - Nov 2017.

# Cambia "Stretch_mode" y "Stretch_Aspect" en las
# propiedades del proyecto para ver otros resultados..

extends Node

onready var vistaRaiz = get_node("/root")

func _ready():
	# Conectamos la señal "size_changed" del Viewport a nuestro método.
	get_viewport().connect("size_changed",self,"cambioTam")
	# Llamamos manualmente a nuestro método.
	cambioTam()
	# Activamos el procesamiento en cada frame.
	set_process_input(true)

func _input(event):
	# Evento de pulsación.
	if(event.is_pressed()):
		# Tecla ESC.
		if (Input.is_key_pressed( KEY_ESCAPE )):
			get_tree().quit()
		# Cambiar resolución..
		if (Input.is_key_pressed( KEY_A )):
			OS.set_window_size(Vector2(320,480))
			cambioTam()
		if (Input.is_key_pressed( KEY_B )):
			OS.set_window_size(Vector2(640,200))
			cambioTam()
		if (Input.is_key_pressed( KEY_1 )):
			OS.set_window_size(Vector2(320,200))
			cambioTam()
		if (Input.is_key_pressed( KEY_2 )):
			OS.set_window_size(Vector2(640,480))
			cambioTam()
		if (Input.is_key_pressed( KEY_3 )):
			OS.set_window_size(Vector2(800,600))
			cambioTam()
		if (Input.is_key_pressed( KEY_4 )):
			OS.set_window_size(Vector2(1280,1024))
			cambioTam()

func cambioTam():
	var cadena1
	cadena1 = "Juego: "
	cadena1 += str(get_tree().get_root().get_rect().size)
	var cadena2
	cadena2 = " Ventana: "
	cadena2 += str(OS.get_window_size())
	OS.set_window_title(cadena1+cadena2)
	get_node("info").set_text(cadena1+"\n"+cadena2)
