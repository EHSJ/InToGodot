# Matamarcianos DAM
# Desarrollo de Aplicaciones Multiplataforma.
# PMDM - Tarea 05
# Salgüero Jáñez Eugenio Hugo
# 2017 / 05
#
# : enemigo.gd
#	- Movimiento.
#	- Disparos.

extends Area2D

const dado = 750

var nivel 	#Nivel de la partida
var numero = 0	#Nº en la fromación
var tipo = 0	#Tipo de nave
var columna = 0	#Columna y fila en formacion
var fila = 0

var lvl = 1	# Nivel del enemigo
var letraControl
var vida = 100
var energiaMax = 100
var energia
var energiaRegen = 10
var velocidad = 0
var velocidadMax = 10
var chanceDisparo = 0
var chancePasada = 0

# Estado:
#	0: En el escuadrón.
#	1: Haciendo una Pasada de colision.
#	2: Entrando en formación desde arriba.
var estado = 2
var color = 2 	# Rojo
var tirada = dado	# Chance inicializada a una tirada fallida.
var objetivo = null
var objetivoPos
var objetivoPath
var segundero = 0
var p = null	# referencia al progenitor
var img = null
var barVida

# INICIO: Puesta en escena.
func _ready():
	# Variables iniciales Comunes a todos.
	p = get_parent()	# Referencia a la partida, que es el progenitor.
	img = get_node("img")
	barVida=get_node("barVida")
	barVida.hide()
	nivel = p.nivel		# Nivel jugado.
	lvl=4-fila
	energiaRegen = 5+lvl*2

	# Configuración específica del Enemigo.
	if(tipo==0):
		print("¡Excepción! Se ha creado un enemigo tipo 0.")
		queue_free()
	elif(tipo==1): # Caza : Disparo normal.
		letraControl="A"
		vida = lvl				# 1..5
		energiaMax = 15+lvl		# 15..20
		velocidadMax = 4
		chanceDisparo = nivel*4
		chancePasada = nivel*5
	elif(tipo==2): # Interceptor : Atake rasante veloz.
		letraControl="B"
		vida = lvl				# 1..5
		energiaMax = 15+lvl		# 15..20
		velocidadMax = 6
		chanceDisparo = nivel*4
		chancePasada = nivel*6
	elif(tipo==3): # Asalto : Laser Pesado.
		letraControl="C"
		vida = 2+lvl			# 3..8
		energiaMax = 25+lvl*2	# 25..35
		velocidadMax = 4
		chanceDisparo = nivel*6
		chancePasada = nivel*4
	elif(tipo==4): # Torpedero : Torpedos.
		letraControl="D"
		vida = 3+lvl			# 4..9
		energiaMax = 30+lvl*3	# 30..45
		velocidadMax = 3
		chanceDisparo = nivel*6
		chancePasada = nivel*4
	elif(tipo==5): # Fantasma : Disparo normal.
		letraControl="E"
		vida = lvl				# 1..5
		energiaMax = 15+lvl		# 15..20
		velocidadMax = 6
		chanceDisparo = nivel*4
		chancePasada = nivel*6
	# Establecer Textura.
	var colorNave
	if(lvl==1):
		colorNave="verde"
	elif(lvl==2):
		colorNave="azul"
	elif(lvl==3):
		colorNave="rojo"
	elif(lvl==4):
		colorNave="negro"
	img.set_texture(load("res://enemigos/"+colorNave+letraControl+".png"))
	# Calcular posición inicial basandose en la fila y columna.
	var x=columna*p.escuadronEspaciadoX+p.escuadronPosX
	var y=fila*p.escuadronEspaciadoY+p.escuadronPosY
	energia=energiaMax
	set_pos(Vector2(x,y))
	barVida.set_max(vida)
	get_node("img/animador").play("aparicion")
	set_fixed_process(true)

# BUCLE Principal.
func _fixed_process(delta):
	# Obtiene la posición.
	var pos = get_pos()
	#  Acciones a ejecutar cada segundo aproximadamente.
	segundero+=delta			# Añade el tiempo transcurrido.
	if(segundero>=1):
		segundero=0				# Resetea el contador.
		tirada=randi()%dado		# Tira el dado.
		if(energia<energiaMax):	# Aumenta la energia.
			energia += energiaRegen

	# Estado 0: En Formación.
	# Calculos para hacer una pasada o disparar.
	if(estado==0):
		# Disparar desde la formación si no está muy bajo y tiene energia.
		if((pos.y<p.partidaY)&&(energia>10)&&(tirada%2==0)):
			if(tirada<=chanceDisparo):	# Disparo Vertical
				disparo(energia,pos.x,1000)
				tirada=dado	# Resetea la tirada.

		# Ordenar Pasada de Ataque.
		if(energia>=energiaMax/3):		# Tiene Energia?
			if(tirada<=chancePasada):	# Atacar!
				objetivo=seleccionarObjetivo()
				energia-=energiaMax/3	# Restamos un tercio de la energia.
				set_z(get_z()+1)		# Elevamos el gráfico.
				estado=1				# Estado -> Pasada.
				tirada=dado				# Resetea la tirada.

	# Estado 0 ó 2: En el escuadron o volviendo.
	# Movimiento lateral.
	if((estado==0)||(estado==2)):
		if(p.avanceDerecha):
			pos.x+=p.escuadronVelX*delta
			if(pos.x>p.partidaX-p.partidaMargenX):
				p.invertirAvance=true
		else: # Avance Izquierda
			pos.x-=p.escuadronVelX*delta
			if(pos.x<0+p.partidaMargenX):
				p.invertirAvance=true
	# Estado 1: Pasada de Ataque.
	# Movimiento lateral y vertical.
	if(estado==1):
		# Si es del tipo Fantasma, se oculta.
		if((tipo==5)&&get_opacity()>0.25):
			set_opacity(get_opacity()-0.01)
		pos.y+=velocidad		# Desciende.
		if(pos.y>p.partidaY):	# Terminó la pasada?
			estado=2
			velocidad=velocidadMax
			objetivo=null
			set_z(get_z()-1)
			pos.y=0
			pos.x=columna*p.escuadronEspaciadoX+p.escuadronPosX
			# Si es del tipo Fantasma, se Desoculta.
			if(tipo==5):
				set_opacity(1)
		else:	# Movimiento Horizontal.
			if (p.has_node(objetivoPath)):
				objetivoPos=objetivo.get_pos()
			if(velocidad<velocidadMax):
				velocidad+=2*delta
			if(pos.x<objetivoPos.x):
				pos.x+=velocidad*delta
			elif(pos.x>objetivoPos.x):
				pos.x-=velocidad*delta
			# Posición de Disparo?
			if((pos.y>p.partidaY/4*3)&&(pos.y<p.partidaY/6*5)&&(energia>energiaMax/3)):
				# Disparar!
				disparo(energia,objetivoPos.x,objetivoPos.y)
	# Estado 2: Regreso al escuadron.
	# Movimiento vertical.
	if(estado==2):
		pos.y+=velocidad
		if(pos.y>=fila*p.escuadronEspaciadoY+p.escuadronPosY):
			pos.y=fila*p.escuadronEspaciadoY+p.escuadronPosY
			estado=0
			velocidad=0
	# Establece la posición actualizada.
	set_pos(pos)
	barVida.set_value(vida)

	if (p.jugadoresVivos == 0):
		estado = 3
	# Controla la Vida.
	if(vida<=0):
		# TODO: Animacion!
		p.numeroEnemigos -= 1
		queue_free()

func disparo(carga,x,y):
	var posicion = get_pos()
	var disparo = preload("res://disparos/disparo.tscn").instance()
	energia-=carga
	disparo.color=color
	disparo.energia=carga
	disparo.objetivoX=x
	disparo.objetivoY=y
	posicion.y+=25
	disparo.set_pos(posicion)
	p.add_child(disparo)
#	print("Enemigo: "+str(numero)+" "+str(letraControl)+" disparó "+str(numero)+" energia.")

func seleccionarObjetivo():
	# Si hay Dos Jugadores devuelve uno al 50%.
	# Si no siempre el Jugador Uno.
	if((p.jugadoresVivos==2)&&(randi()%2==1)):
		objetivoPath=p.get_node("p2").get_path()
		return p.get_node("p2")
	elif (p.jugadoresVivos != 0):
		objetivoPath=p.get_node("p1").get_path()
		return p.get_node("p1")
	else: return null


func _on_enemigo_area_enter( area ):
	# Solamente colisionamos con el otro bando.
	if(area.color!=color):
		# Colisión con jugador.
		if(area.is_in_group("nave")):
			# Mata al jugador.
			area.vida = 0
			# Mata al enemigo.
			vida = 0
		else:
			barVida.show()