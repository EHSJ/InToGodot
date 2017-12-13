# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Panel

onready var consola = get_node("consola")
onready var comandos = get_node("comandos")

var tiempoIniciando = 1.0
var iniciando = true
var prompt = ">> "
var colorNormal = "white"
var colorError = "red"
var colorSalida = "green"
var txtInicio = """
----------------------------------------------------------------------
	Bienvenido al Ejemplo de Terminal.

>> """


func _ready():
	comandos.connect("text_entered",self,"_comandoIntroducido")
	comandos.grab_focus()
	consola.set_selection_enabled(true)
	iniciarConsola()

func iniciarConsola():
	consola.clear()
	consola.set_text(txtInicio)
	consola.set_percent_visible(0)
	tiempoIniciando = 1.0
	iniciando = true
	set_process(true)

func _process(delta):
	if ( iniciando ):
		tiempoIniciando = tiempoIniciando - delta
		if ( tiempoIniciando <= 0 ):
			iniciando = false
			consola.set_percent_visible(1)
			set_process(false)
		else:
			consola.set_percent_visible(1-tiempoIniciando)

func prompt():
	consola.newline()
	consola.add_text(prompt)

func _comandoIntroducido( comando ):
	# Limpiar la entrada de comandos.
	comandos.clear()
	if (comando == "clear"):
		consola.clear()
		prompt()
	elif (comando == "info"):
		comSistema()
		prompt()
	elif (comando == "ayuda"):
		comAyuda()
	elif (comando == "salir") || (comando == "quit"):
		get_tree().quit()
	else:
		consola.append_bbcode("[color="+colorError+"]"+comando+"[/color] no encontrado.")
		prompt()

func comAyuda():
	var txtAyuda = """
	ayuda		-> Muestra esta ayuda.
	clear		-> Limpia la consola.
	quit
	salir		-> Salir.
	"""
	consola.add_text("----------------------------------------------------------------------")
	consola.append_bbcode("[color="+colorSalida+"]"+txtAyuda+"[/color]")
	prompt()

func comSistema():
	consola.append_bbcode("nombre del sistema: [color="+colorSalida+"]"+OS.get_name()+"[/color]")
