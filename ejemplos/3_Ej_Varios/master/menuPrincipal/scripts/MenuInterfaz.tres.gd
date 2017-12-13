# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends MenuButton

export (NodePath) var popupPath	# Padre donde guardamos los popups, por comodidad.

onready var popPupPadre = get_node( popupPath )
onready var popup = get_popup()

func _ready():
	popup.connect("item_pressed", self, "_on_item_pressed")

func _on_item_pressed( id ):
	print(id,popup.get_item_text( id ), " pressed")
	if ( popup.get_item_ID( id ) == 0 ):
		var ventana = popPupPadre.get_node( "Anclas" )
		ventana.popup()
	# Controles:
	if ( popup.get_item_ID( id ) == 1 ):
		ControlesGenerales.cambiarEscena( "res://ej_Interfaz/integracion/EjemploIntegracion.tscn" )
	# Terminal:
	if ( popup.get_item_ID( id ) == 2 ):
		var ventana = popPupPadre.get_node( "Terminal" )
		ventana.popup()
	# ControlTree:
	if ( popup.get_item_ID( id ) == 3 ):
		var ventana = popPupPadre.get_node( "ControlTree" )
		ventana.popup()
	# Hoja de Personaje:
	if ( popup.get_item_ID( id ) == 4 ):
		ControlesGenerales.cambiarEscena( "res://ej_Interfaz/hojaDePersonaje/HojaPj.tscn" )
