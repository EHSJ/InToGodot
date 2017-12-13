# Introducción a Godot.
# ScrollCamara2D
# Ejemplo de control de Cámara con ratón.
# E.H.S.J - Nov 2017.


extends Camera2D
# Valores del Zoom.
export(float,0.5,1,0.25) var zoomMin = 0.5
export(float,1,50,0.5) var zoomMax = 2
export(float,0.1,2,0.1) var zoomPaso = 0.1

var mover = false
# Almacena las posiciones
var initPosCam
var initPosMouse

func _ready():
	# Establece esta cámara como Activa. (No es necesario cuando solo hay una en escena)
	make_current()
	initPosCam=get_global_pos()
	# Este nodo recibira las entradas via _input.
	set_process_input(true)

func _input(event):
	# Evento de pulsación.
	if(event.is_pressed()):
		# Tecla ESC.
		if(Input.is_key_pressed(KEY_ESCAPE)):
			# Salir del programa.
			get_tree().quit()

	# Evento de Botón del Ratón.
	if (event.type == InputEvent.MOUSE_BUTTON):
		# La rueda gestiona el zoom.
		if (event.button_index == BUTTON_WHEEL_DOWN):
			HacerZoom(1) # Positivo, alejar.
		if (event.button_index == BUTTON_WHEEL_UP):
			HacerZoom(-1) # Negativo, acercar.
		# El izquierdo gestiona el desplazamiento.
		if (event.button_index == BUTTON_LEFT):
			# Se ha presionado.
			if(Input.is_mouse_button_pressed(BUTTON_LEFT)):
				# Almacenamos la posición inicial.
				initPosCam = get_pos()
				# Posición del ratón.
				initPosMouse = get_global_mouse_pos()
				# Bandera de Desplazamiento
				mover = true
			# Se ha soltado el boton.
			else:
				mover = false

	# Evento de Movimiento del Ratón.
	if (event.type == InputEvent.MOUSE_MOTION):
		# Si está en modo desplazamiento.
		if(mover == true):
			# Captura la nueva posición del ratón.
			var mouse_pos = get_global_mouse_pos()
			# Distancia del movimiento.
			var dist_x = initPosMouse.x - mouse_pos.x
			var dist_y = initPosMouse.y - mouse_pos.y
			# Calcula nueva posición de la cámara.
			var mx = initPosCam.x - round(dist_x)
			var my = initPosCam.y - round(dist_y)
			var posicion=Vector2(mx,my)
			# La establece.
			set_pos(posicion)

func HacerZoom(sentido):
	var zoom = get_zoom()
	if(sentido>0):
		if(zoom.x<zoomMax):
			zoom.x += zoomPaso
			zoom.y += zoomPaso
	elif(sentido<0):
		if(zoom.x>zoomMin):
			zoom.x -= zoomPaso
			zoom.y -= zoomPaso
	set_zoom(zoom)