# Matamarcianos DAM
# Desarrollo de Aplicaciones Multiplataforma.
# PMDM - Tarea 05
# Salgüero Jáñez Eugenio Hugo
# 2017 / 05
#
# : partida.gd
#	- Bucle principal del juego.
#	- Gestiona la creación de enemigos
#	- Movimiento del escuadrón.
#	- Condiciones de fin de nivel y fin de partida.

extends Node

## CONSTANTES:
# Espaciado entre naves X e Y.
const escuadronEspaciadoX = 90
const escuadronEspaciadoY = 90
# Nº de Naves en X e Y.
const escuadronTamX = 13
const escuadronTamY = 4
# Máximo de Enemigos.
const maxEnemigos = escuadronTamX* escuadronTamY
## Tabla de Formaciones.
# 	Tipo de Enemigo:
# 	0: Posición Vacia.
# 	1: Caza Mk1.
# 	2: Interceptor.
# 	3: Asalto.
# 	4: Torpedero.
# 	5: Fantasma.
## Formación Cero (Plantilla).
const formacion0 =[
	0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,0,0,0,0,0	]
# "Boss" : %0
const formacionB1 =[
	0,0,0,0,0,5,4,5,0,0,0,0,0,
	0,0,1,1,1,5,5,5,1,1,1,0,0,
	0,0,0,1,1,1,0,1,1,1,0,0,0,
	0,0,0,0,1,1,1,1,1,0,0,0,0	]
# "Bloks" : %1
const formacionA =[
	0,2,3,2,0,5,4,5,0,2,3,2,0,
	0,1,1,1,0,2,3,2,0,1,1,1,0,
	0,1,1,1,0,1,1,1,0,1,1,1,0,
	0,1,1,1,0,1,1,1,0,1,1,1,0	]
# "Snakes" : %2
const formacionB =[
	3,1,1,3,1,1,3,1,1,3,1,1,1,
	0,2,0,0,2,0,0,2,0,0,2,0,0,
	0,0,1,0,0,1,4,4,1,0,0,1,0,
	5,0,0,1,0,0,1,4,4,1,0,0,1	]
# "s/n" : %3
const formacionC =[
	0,4,4,4,0,0,0,0,0,4,4,4,0,
	0,3,3,3,0,0,0,0,0,3,3,3,0,
	2,2,2,2,2,0,0,0,2,2,2,2,2,
	1,1,1,1,1,0,0,0,1,1,1,1,1	]
# "s/n" : %4
const formacionD =[
	4,0,4,0,0,5,5,5,0,0,4,0,4,
	0,4,0,0,0,5,5,5,0,0,0,4,0,
	3,2,3,2,3,2,3,2,3,2,3,2,3,
	2,1,2,1,2,1,2,1,2,1,2,1,2	]
# "s/n" : %5
const formacionE =[
	0,0,0,5,5,5,5,5,5,5,0,0,0,
	2,1,2,1,2,1,2,1,2,1,2,1,2,
	3,5,3,5,3,5,3,5,3,5,3,5,3,
	2,1,2,1,2,1,2,1,2,1,2,1,2	]

## VARIABLES.
# Nivel inicial.
export(int,1,99) var nivel = 1
# Número de Jugadores.
export(int,"TEST","Un Jugador","Dos Jugadores") var jugadores = 1
# Formaciones incluidas en los niveles.
var plantillaFormacion = [formacionB1,formacionA,formacionB,formacionC,formacionD,formacionE]
# Fondos
var fondos = ["black","blue","darkPurple","purple"]
# Nº actual de enemigos.
var numeroEnemigos = 0
var jugadoresVivos
# posición inicial del escuadron X e Y.
var escuadronPosX = 120
var escuadronPosY = 100
# Bandera de invertir.
var invertirAvance = false
# Sentido del avance.
var avanceDerecha = true
# Velocidad de movimiento del escuadron.
var escuadronVelX = 100
var escuadronVelY = 0 # No usada.
# Tamaños de la zona del escuadron y margen:
var partidaX = 1920
var partidaMargenX = escuadronEspaciadoX/2
var partidaY = 1080
var partidaMargenY = escuadronEspaciadoY/2
# Puntuaciones.
var puntosP1 = 0
var puntosP2 = 0
# Referencias para el GUI:
var guiNivel
var guiPuntos1
var guiPuntos2
# Referencia a los Jugadores
var p1
var p2
# Modo Pruebas.
var debug = false

# Función _ready():
# Se ejecuta UNA vez se ha cargado el nodo y todos sus hijos.
# -----------------------------------------------------------------------------------------
func _ready():
	# Obtener las referencias al gui:
	guiNivel = get_node("guiNivel")
	guiPuntos1 = get_node("guiPuntos1")
	guiPuntos2 = get_node("guiPuntos2")

	## Crear Jugadores:
	# Cargar nave del jugador
	var jugador = preload("res://jugador/jugador.tscn")
	# Configurar primer jugador para Single.
	if(jugadores!=0):
		p1=jugador.instance()
		p1.set_name("p1")
		p1.color=0
		# Dos Jugadores.
		if(jugadores==2):
			# Colocamos el P1 para dobles.
			p1.set_pos(Vector2((partidaX/3)*2,1000))
			p2=jugador.instance()
			p2.set_name("p2")
			p2.color=1
			# Colocamos el P2 para dobles.
			p2.set_pos(Vector2(partidaX/3,1000))
			add_child(p2)
		# Colocamos el P1 para single.
		elif(jugadores==1):
			p1.set_pos(Vector2(partidaX/2,1000))
		add_child(p1)
	else:
		debug = true
	jugadoresVivos = jugadores
	# Crear el nivel.
	nuevoNivel(nivel)
	# Activamos la función _process(delta):
	set_process(true)

# Función _process(delta):
# Se ejecuta en cada imagen (frame) del juego.
#	- delta : tiempo transcurrido desde el último frame, en ms.
# -----------------------------------------------------------------------------------------
func _process(delta):
	## Salir del juego si se pulsa ESC.
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	## DEBUG:
	if (debug):
		if (Input.is_action_pressed("ui_select")):
			debugLevelUp()
			OS.delay_msec(500)

	## PARTIDA:
	else:
		## Control de Fin del Nivel.
		if(numeroEnemigos==0):
			# TODO: Fin de nivel!
			nuevoNivel(nivel+1)
		## Controla el Movimiento del escuadrón.
		if(avanceDerecha):
			escuadronPosX+=escuadronVelX*delta
			# Si llega al borde invertir.
			if(escuadronPosX>partidaX):
				invertirAvance = true
		else:
			escuadronPosX-=escuadronVelX*delta
			# Si llega al borde invertir.
			if(escuadronPosX<0):
				invertirAvance = true
		## Control de la inversión de rumbo.
		if(invertirAvance):
			avanceDerecha = !avanceDerecha
			invertirAvance = false
		## Actualizar marcadores.
		guiPuntos1.set_text("P1: "+str(puntosP1))
		guiPuntos2.set_text("P2: "+str(puntosP2))
		## Control Fin de Partida.
		if (jugadoresVivos == 0):finPartida()

# Función nuevoNivel(nuevoLvl):
# -----------------------------------------------------------------------------------------
func nuevoNivel(nuevoLvl):
	# Establece el nivel a cargar como el actual.
	nivel=nuevoLvl
	var fondoPath = "res://fondos/"+str(fondos[nivel%fondos.size()])+".png"
	get_node("fondo/ParallaxLayer/fondo").set_texture(load(fondoPath))
	# Crear Enemigos.
	for contador in range(maxEnemigos):
		if(plantillaFormacion[nivel%plantillaFormacion.size()][contador]!=0):
			crearEnemigo(contador,plantillaFormacion[nivel%plantillaFormacion.size()][contador])
	# Actualizar GUI.
	guiNivel.set_text("Nivel: "+String(nivel)+".")
	# Log.
	print(str(numeroEnemigos)+" enemigos creados para el nivel "+str(nivel)+" con Fondo: "+fondoPath)

# Función crearEnemigo(numero,tipo):
# -----------------------------------------------------------------------------------------
func crearEnemigo(numero,tipo):
	# El tipo 0 se utiliza para marcar un vacio.
	if(tipo == 0):
		return
	# Cargar enemigo.
	var enemigo = preload("res://enemigos/enemigo.tscn").instance()
	# Configurar.
	enemigo.numero = numero
	enemigo.columna = numero%escuadronTamX
	enemigo.fila = numero/escuadronTamX
	enemigo.tipo = tipo
	# Añadirlo a la partida.
	add_child(enemigo)
	numeroEnemigos += 1
# -----------------------------------------------------------------------------------------
func finPartida():
	var escenaActual = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	var menu = preload ("res://menus/menuPrincipal.tscn").instance()
	get_tree().get_root().call_deferred("add_child",menu)
	escenaActual.queue_free()

func debugLevelUp():
	var escenaActual = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	var partida = preload ("res://partida/partida.tscn").instance()
	partida.nivel = nivel + 1
	get_tree().get_root().call_deferred("add_child",partida)
	escenaActual.queue_free()
