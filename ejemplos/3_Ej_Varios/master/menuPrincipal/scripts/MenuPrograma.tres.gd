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
		var popup = popPupPadre.get_node( "AcercaDe" )
		# var acercaDialog = popPupPadre.get_node( "AcercaDe2" )
		popup.popup()
		#  acercaDialog.show() Muestra el popup, Pero No genera la señal 'about_to_show'
	if ( popup.get_item_ID( id ) == 1 ):
		var popup = popPupPadre.get_node( "Rendimiento" )
		popup.popup()
	if ( popup.get_item_ID( id ) == 3 ):
		get_tree().quit()

func _on_Presentacion_pressed():
	var popup = popPupPadre.get_node( "Presentacion" )
	popup.popup()
