# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends MenuButton

export (NodePath) var popupPath	# Padre donde guardamos los popups, por comodidad.

onready var popPupPadre = get_node( popupPath )
onready var popup = get_popup()

func _ready():
	popup.connect("item_pressed", self, "_on_item_pressed")

func _on_item_pressed( id ):
	if ( popup.get_item_ID( id ) == 2 ):
		ControlesGenerales.cambiarEscena( "res://ej_Node2D/sprite/EjemploSprite.tscn" )
	if ( popup.get_item_ID( id ) == 1 ):
		ControlesGenerales.cambiarEscena( "res://ej_Node2D/iluminacion2D/EjemploIluminación2D.tscn" )
	if ( popup.get_item_ID( id ) == 0 ):
		ControlesGenerales.cambiarEscena( "res://ej_Node2D/fondoParallax/EjemploFondoParallax.tscn" )
	if ( popup.get_item_ID( id ) == 3 ):
		ControlesGenerales.cambiarEscena( "res://ej_Node2D/tileset/EjemploTileset.tscn" )
	if ( popup.get_item_ID( id ) == 4 ):
		ControlesGenerales.cambiarEscena( "res://ej_Node2D/nivel/EjemploNivel.tscn" )
	if ( popup.get_item_ID( id ) == 5 ):
		ControlesGenerales.cambiarEscena( "res://ej_Node2D/particulas2D/EjemploParticulas.tscn" )
