# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Panel

export (NodePath) var objetivoPath
onready var objetivo = get_node( objetivoPath )

export var minimo = 0.0
export var maximo = 0.0
export var paso = 0.0
export var inicial = 0.0
export var setter = ""

var valido = true
var valor = 0.0
var cSlider = null
var cSpin = null

func _ready():
	# Comprobación
	if ( ! objetivo.has_method( setter )):
		print( get_name()," Error en el Setter." )
		valido = false

	cSlider = get_node( "HSlider" )
	cSpin = get_node( "SpinBox" )

	if ( cSlider == null ):
		print( get_name()," Error en control Slider." )
		valido = false
	if ( cSpin == null ):
		print( get_name()," Error en control SpinBox." )
		valido = false

	if ( valido ):
		valor = inicial
		objetivo.call( setter, valor )
		configurarRango( cSlider )
		configurarRango( cSpin )

func configurarRango( nodo ):
	nodo.set_min( minimo )
	nodo.set_max( maximo )
	nodo.set_step( paso )
	nodo.set_value( valor )
	nodo.connect("value_changed",self,"_cambio")

func _cambio( nuevo ):
	valor = nuevo
	cSlider.set_value( valor )
	cSpin.set_value( valor )
	objetivo.call( setter, valor )
