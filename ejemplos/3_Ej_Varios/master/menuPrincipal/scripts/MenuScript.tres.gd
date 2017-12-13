# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends MenuButton

export (NodePath) var popupPath	# Padre donde guardamos los popups, por comodidad.

onready var popPupPadre = get_node( popupPath )
onready var popup = get_popup()

func _ready():
	popup.connect("item_pressed", self, "_on_item_pressed")

func _on_item_pressed( id ):
	if ( popup.get_item_ID( id ) == 0 ):
		var ventana = popPupPadre.get_node( "CicloDeVida" )
		ventana.popup()
	if ( popup.get_item_ID( id ) == 1 ):
		var ventana = popPupPadre.get_node( "UsoDeClases" )
		ventana.popup()
	if ( popup.get_item_ID( id ) == 2 ):
		var ventana = popPupPadre.get_node( "Parser" )
		# ventana.popup()
