# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Node
# Referencia a la nave Activa.
export (NodePath) var nave = null

enum {TECLADO, TECLADO_RATON, MANDO }

# Variables de Identificanción del Jugador.
export(int,"Teclado","Teclado + Raton","Mando") var control = 0
export(int,"ninguno","P1","P2","P3","P4") var jugador = 0
export(int,"ninguno","Negro","Rojo","Verde","Azul","Naranja") var equipo = "ninguno"

var acciones = {}

func _ready():
	nave = get_node(nave)
	nave.equipo = equipo

# Asignación de Teclas a las Ordenes.
	if(jugador==0): # No Player no keys..
		pass
	elif(jugador==1): # Asignación Teclas por Jugador.
		acciones.giroDerecha = "P"+str(jugador)+"_GiroDerecha"
		acciones.giroIzquierda = "P"+str(jugador)+"_GiroIzquierda"
		acciones.lateralDerecha = "P"+str(jugador)+"_LateralIzquierda"
		acciones.lateralIzquierda = "P"+str(jugador)+"_LateralDerecha"
		acciones.acelerar = "P"+str(jugador)+"_Acelerar"
		acciones.reversa = "P"+str(jugador)+"_Reversa"
		acciones.parar = "P"+str(jugador)+"_Parar"
		acciones.turbo = "P"+str(jugador)+"_Turbo"
		acciones.disparoA = "P"+str(jugador)+"_DisparoA"
		acciones.disparoB = "P"+str(jugador)+"_DisparoB"
	set_process(true)

func _process(delta):
	if ( control == TECLADO ):
		procesarTeclado()

func procesarTeclado():
	# Teclado: Acelerar.
	if(Input.is_action_pressed(acciones.acelerar) and Input.is_action_pressed(acciones.reversa)):
		nave.ordenes.avance.valor = 0
	elif (Input.is_action_pressed(acciones.acelerar)): nave.ordenes.avance.valor = 1
	elif (Input.is_action_pressed(acciones.reversa)): nave.ordenes.avance.valor = -1
	else: nave.ordenes.avance.valor = 0

	# Teclado: Strafe.
	if(Input.is_action_pressed(acciones.lateralDerecha) and Input.is_action_pressed(acciones.lateralIzquierda)):
		nave.ordenes.strafe.valor = 0
	elif (Input.is_action_pressed(acciones.lateralIzquierda)): nave.ordenes.strafe.valor = 1
	elif (Input.is_action_pressed(acciones.lateralDerecha)): nave.ordenes.strafe.valor = -1
	else: nave.ordenes.strafe.valor = 0

	# Teclado: Giro.
	if(Input.is_action_pressed(acciones.giroDerecha) and Input.is_action_pressed(acciones.giroIzquierda)):
		nave.ordenes.giro.valor = 0
	elif (Input.is_action_pressed(acciones.giroIzquierda)): nave.ordenes.giro.valor = -1
	elif (Input.is_action_pressed(acciones.giroDerecha)): nave.ordenes.giro.valor = 1
	else: nave.ordenes.giro.valor = 0

	if(Input.is_action_pressed(acciones.parar)):
		nave.ordenes.parar.estado = true
	else: nave.ordenes.parar.estado = false

	if(Input.is_action_pressed(acciones.turbo)): nave.ordenes.turbo.estado = true
	else: nave.ordenes.turbo.estado = false

	if(Input.is_action_pressed(acciones.disparoA)): nave.ordenes.disparoA.estado = true
	else: nave.ordenes.disparoA.estado = false

	if(Input.is_action_pressed(acciones.disparoB)): nave.ordenes.disparoB.estado = true
	else: nave.ordenes.disparoB.estado = false
