extends Node

# Introducción a Godot.
# E.H.S.J - Nov 2017.

onready var menuPrincipal = load( "res://menuPrincipal/MenuPrincipal.tscn")
var menuActivo = true
var escenaActual = null

func _ready():
	# Almacenamos un acceso rápido a root.
	var root = get_tree().get_root()
	# Asignamos la escena actual a la variable.
	escenaActual = root.get_child( root.get_child_count()-1 )
	print(" ControlesGenerales cargados.")
	set_process_input(true)


func insertarMernu():
	get_tree().get_root().add_child(menuPrincipal.instance())


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

func capturaPantalla():
	print("Captura de pantalla.")
	get_viewport().queue_screen_capture()
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	var screenshot = get_viewport().get_screen_capture()
	screenshot.save_png("user://Captura.png")

func cambiarEscena( ruta ):
	# Esta función será llamada por una señal de la escena, solicitando el cambio.
	# Eliminar la escena actual en este punto puede causar fallos al estar en ejecución,
	# por lo que llamaremos a _cambiarEscenaAplazada en modo deferred, para que se
	# ejecute cuando acabe la ejecución pendiente.
	call_deferred("cambiarEscenaAplazada",ruta)

func cambiarEscenaAplazada( ruta ):
	# Carga la nueva escena.
	var s = ResourceLoader.load(ruta)
	# Elimina el Menú Principal.
	if ( menuActivo ):
				menuActivo = false
				get_tree().get_root().get_node("MenuPrincipal").queue_free()
	# Libera la escena actual.
	escenaActual.free()
	# Instancia la nueva escena.
	escenaActual = s.instance()
	# La añadimos como hija de root.
	get_tree().get_root().add_child(escenaActual)
	# Opcional, para hacerlo compatible con la API SceneTree.change_scene()
	get_tree().set_current_scene(escenaActual)
