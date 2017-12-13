# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Panel

export (NodePath) var objetivoPath
onready var objetivo = get_node( objetivoPath )
export var minimo = 0.0
export var maximo = 0.0
export var paso = 0.0
export var inicial = 0.0
export var parametro = 0
export var aleatorio = false

var valido = true
var valor = 0.0
var cSlider = null
var cSpin = null
var valorA = 0.0
var cSliderA = null
var cSpinA = null


func _ready():
	cSlider = get_node( "HSlider" )
	cSpin = get_node( "SpinBox" )

	# Comprobación
	if ( cSlider == null ):
		print( get_name()," Error en control Slider." )
		valido = false
	if ( cSpin == null ):
		print( get_name()," Error en control SpinBox." )
		valido = false

	if ( valido ):
		valor = inicial
		objetivo.call( "set_param", parametro, valor )
		configurarRango( cSlider )
		configurarRango( cSpin )

		if ( aleatorio ):
			cSliderA = get_node( "RandSlider" )
			cSpinA = get_node( "RandSpin" )
			configurarRangoAleatorio( cSliderA )
			configurarRangoAleatorio( cSpinA )
			objetivo.call( "set_randomness", parametro, 0 )


func configurarRango( nodo ):
	nodo.set_min( minimo )
	nodo.set_max( maximo )
	nodo.set_step( paso )
	nodo.set_value( valor )
	nodo.connect("value_changed",self,"_cambio")

func configurarRangoAleatorio( nodo ):
	nodo.set_min( -1 )
	nodo.set_max( 1 )
	nodo.set_step( 0.1 )
	nodo.set_value( 0 )
	nodo.connect("value_changed",self,"_cambioAleatorio")

func _cambio( nuevo ):
	valor = nuevo
	cSlider.set_value( valor )
	cSpin.set_value( valor )
	objetivo.call( "set_param", parametro, valor )

func _cambioAleatorio( nuevo ):
	valorA = nuevo
	cSliderA.set_value( valorA )
	cSpinA.set_value( valorA )
	objetivo.call( "set_randomness", parametro, valorA )
