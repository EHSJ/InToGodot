tool
extends Panel

export (String, FILE ) var fotoFile setget set_fotoFile
export var titulo = "" setget set_titulo

var foto = null
onready var imagen = get_node( "marco/imagen" )
onready var etiqueta = get_node( "titulo" )

func _ready():
	if ( fotoFile != "" ):
		foto = load ( fotoFile )
	actualiza()

# Aplicar los cambios a los Nodos.
func actualiza():
	if ( foto != null && imagen != null ):
		imagen.set_texture( foto )
	if ( etiqueta != null ):
		etiqueta.set_text( titulo )

# Setters & Getters:
func set_fotoFile( nuevo ):
	fotoFile = nuevo
	if ( fotoFile != null && fotoFile != "" ):
		foto = load ( fotoFile )
	actualiza()

func set_titulo ( nuevo ):
	titulo = nuevo
	actualiza()