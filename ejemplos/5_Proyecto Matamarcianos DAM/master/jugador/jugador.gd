# Matamarcianos DAM
# Desarrollo de Aplicaciones Multiplataforma.
# PMDM - Tarea 05
# Salgüero Jáñez Eugenio Hugo
# 2017 / 05
#
# : jugador.gd
#	- Movimiento.
#	- Disparos.

extends Area2D

## VARIABLES:
# Color/Jugador.
export (int,"Azul","Verde") var color=0
# Flag, se esta moviendo.
var moviendose=false
# Aceleración del jugador.
var acel = 500
# Velovidad Horizontal.
var velocidadX = 0
# Vida:
var vidaMax = 100
var vida = vidaMax
# Energia:
var energiaMax = 25
var energia = energiaMax
# Recarga de Energia *s.
var energiaRegen = energiaMax/5
# Cargad el disparo.
var carga = 0
# Velocidad de Carga del laser *s.
var velCarga = energiaMax/5
# Para cosas que pasan cada segundo exacto.
var segundero = 0
# Para separar los "inputs".
var letraControl
## REFERENCIAS:
# Partida.
var p
# Barras.
var barVida
var barEnergia
var barCarga
# Sprite del jugador.
var img
# Particulas de carga.
var partCarga

# Función _ready():
# Se ejecuta UNA vez se ha cargado el nodo y todos sus hijos.
# -----------------------------------------------------------------------------------------
func _ready():
	## Referenciar los nodos a utilizar.
	# Partida (el padre de todos los objetos de la partida)
	p=get_parent()
	# Sprite de la Nave.
	img=get_node("img")
	# Resto de Nodos del jugador..
	partCarga=get_node("partCarga")
	barVida=get_node("barVida")
	barEnergia=get_node("barEnerg")
	barCarga=get_node("barCarga")
	## Configurar las barras.
	barVida.set_max(vidaMax)
	barEnergia.set_max(energiaMax)
	barCarga.set_max(energiaMax)
	# Apagamos el emisor de particulas x si estaba encendido, xa las pruebas.
	partCarga.set_emitting(false)
	barCarga.hide()
	## Distinción del jugador 1 y 2.
	if(color==0):#Azul
		img.set_texture(load("res://jugador/naves/azul.png"))
		letraControl="A"
		partCarga.set_color(Color(0.5,0.5,1))
	elif(color==1):#Verde
		img.set_texture(load("res://jugador/naves/verde.png"))
		letraControl="B"
		partCarga.set_color(Color(0.5,1,0.5))
	# Activamos el proceso del bucle.
	set_fixed_process(true)

# Función _fixed_process(delta)
# Se ejecuta en cada imagen (frame) del juego. Uso integrado con el motor de física.
#	- delta : tiempo transcurrido desde el último frame, en ms.
# -----------------------------------------------------------------------------------------
func _fixed_process(delta):
	# Obtener la posicion.
	var posicion = get_pos()
	## Ordenes de Movimiento del jugador.
	if (Input.is_action_pressed("jugador_"+letraControl+"_izq")):
		if(posicion.x>p.partidaMargenX):	# No ha salido por la Izquierda.
			velocidadX-=acel*delta			# Acelera a izq.
			moviendose=true
	elif (Input.is_action_pressed("jugador_"+letraControl+"_der")):
		if(posicion.x<p.partidaX-p.partidaMargenX):	# No ha salido por la Derecha.
			velocidadX+=acel*delta					# Acelera der.
			moviendose=true
	## Control de Bordes.
	# Se ha salido por la derecha.
	if(posicion.x>p.partidaX-p.partidaMargenX):
		# Se ha salido mucho.
		if(posicion.x>p.partidaX+p.partidaX/10):
			# Rebota.
			posicion.x=p.partidaX+p.partidaX/10
			velocidadX=-velocidadX
		# Se  ha salido poco.
		else:
			# Acelera a Izq. para volver
			velocidadX-=acel*delta
	# Se ha salido por la izquierda.
	elif(posicion.x<p.partidaMargenX):
		# Se ha salido mucho.
		if(posicion.x<0-p.partidaX/10):
			# Rebota.
			posicion.x=0-p.partidaX/10
			velocidadX=-velocidadX
		# Se  ha salido poco.
		else:
			# Acelera a Der. para volver
			velocidadX+=acel*delta
	# Esta dentro
	elif((velocidadX>0)&&(!moviendose)):
		# Frena
		velocidadX-=acel*delta*2
	elif((velocidadX<0)&&(!moviendose)):
		# Frena
		velocidadX+=acel*delta*2
	## Actualiza la posicion.
	posicion.x += velocidadX * delta
	moviendose=false
	## Controla la Vida.
	if(vida<=0):
		pass
	## Input disparo - Cargar disparo.
	if ((Input.is_action_pressed("jugador_"+letraControl+"_fuego"))&&(energia>=velCarga*delta)):
		barCarga.show()
		energia -= velCarga*delta
		carga += velCarga*delta
		# Efecto de cargar (particulas)
		if (carga > energiaMax/2):
			partCarga.set_emitting(true)
	# Si no se está cargando, se vacia el cargador.
	elif(carga>0):
		barCarga.hide()
		disparar()
		# Apagamos el efecto.
		if (partCarga.is_emitting()):
			partCarga.set_emitting(false)
	## Regeneración de energia, solo cada segundo, si no se está cargando el disparo.
	elif(segundero>=1):
		segundero-=1
		if(energia < energiaMax - energiaRegen):
			energia += energiaRegen
		else:
			energia = energiaMax
	# Actualiza la Posición.
	set_pos(posicion)
	# Actualiza el segundero.
	segundero+=delta
	# Actualiza las barras.
	barVida.set_value(vida)
	barEnergia.set_value(energia)
	barCarga.set_value(carga)
	## Muerte.
	if (vida <= 0):
		p.jugadoresVivos -= 1
		queue_free()

# -----------------------------------------------------------------------------------------
func disparar():
	# Posición de la nave.
	var posicion = get_pos()
	# Instancia un disparo.
	var disparo = preload("res://disparos/disparo.tscn").instance()
	# Configurar el disparo.
	disparo.color=color
	disparo.energia=carga+1
	# Colocación inicial.
	posicion.y-=25
	disparo.set_pos(posicion)
	# Se hace hija del nodo partida.
	p.add_child(disparo)
#	get_node("..").add_child(disparo)
	# Reset de la carga.
	carga=0


