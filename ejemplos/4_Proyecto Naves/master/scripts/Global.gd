# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Node

var coloresEquipo = {
	negro = Color(.3,.3,.3),
	rojo = Color(1,0,0),
	verde = Color(0,1,0),
	azul = Color(0,0,1),
	naranja = Color(1,0,1)
	}

enum { WIN_FRAGLIMIT, WIN_FRAGTIME, WIN_POINTLIMIT, WIN_POINTTIME }
enum { ASTRO_NADA, ASTRO_PLANETA, ASTRO_SOL }
enum { BORDES_MUERTE, BORDES_WARP, BORDES_GOMA }
enum { AST_NONE, AST_POCOS, AST_MUCHOS }

var definicionPartida = {
	win = WIN_FRAGLIMIT,
	astro = ASTRO_NADA,
	bordes = BORDES_WARP,
	asteroides = AST_POCOS
	}

func _ready():
	# Modo bajo procesador
	if ( OS.is_in_low_processor_usage_mode() == false ):
		OS.set_low_processor_usage_mode(true)
		print("Ahorro CPU: ",OS.is_in_low_processor_usage_mode())

	print("Debug: ",OS.is_debug_build())
	print("Verbose: ",OS.is_stdout_verbose())
