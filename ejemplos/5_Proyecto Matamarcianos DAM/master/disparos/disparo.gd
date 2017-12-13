# Matamarcianos DAM
# Desarrollo de Aplicaciones Multiplataforma.
# PMDM - Tarea 05
# Salgüero Jáñez Eugenio Hugo
# 2017 / 05
#
# : disparo.gd

extends Area2D

var velocidad=500
var energia=0
var vida
var lvl
var disiparDelta = 0
var color
var objetivoX = 0
var objetivoY = 0
var img

# Función _ready():
# Se ejecuta UNA vez se ha cargado el nodo y todos sus hijos.
# -----------------------------------------------------------------------------------------
func _ready():
	var cadena
	if(color==0):#Azul
		cadena="azul"
	elif(color==1):#Verde
		cadena="verde"
	elif(color==2):#Rojo
		cadena="rojo"

	if(energia<=5):lvl=1
	elif(energia<=10):lvl=2
	elif(energia<=20):lvl=3
	elif(energia<30):lvl=4
	elif(energia>=30):lvl=5
	vida=energia

	get_node("img").set_texture(load("res://disparos/"+cadena+"0"+str(lvl)+".png"))
	if(color==2):
		look_at(Vector2(objetivoX,objetivoY))

	get_parent().get_node("sonidos").play("disparo")
	set_fixed_process(true)


# Función _fixed_process(delta):
# Se ejecuta en cada imagen (frame) del juego.
# A diferencia de _process(delta) _fixed es la indicada si el nodo interviene en el motor de físicas,
# en este caso para las colisiones.
#	- delta : tiempo transcurrido desde el último frame, en ms.
# -----------------------------------------------------------------------------------------
func _fixed_process(delta):
	# Obtener posición.
	var posicion = get_pos()
	# Control de extinción.
	if(energia<=0):self.queue_free()
	if (posicion.y<0):self.queue_free()
	# Si es enemigo, invierte el movimiento.
	if(color!=2):
		move_local_y(-velocidad*delta,true)
	else:
		move_local_y(velocidad*delta,true)
	# Actualizar etiqueta de debug.
	if (get_node("labelEnergia").is_visible()):
		get_node("labelEnergia").set_text(global.romanos(lvl)+" : "+str(energia))

# -----------------------------------------------------------------------------------------
func _on_disparo_area_enter( area ):
	if(area.color!=color):
		# Colisión con otro disparo.
		if(area.is_in_group("disparo")):
			# There can be only One.."
			if (area.energia > energia):
				area.energia -= energia
				energia = 0
			else:
				energia -= area.energia
				area.energia = 0
		# Era una nave..
		else:
			get_parent().get_node("sonidos").play("impacto")
			area.vida-=energia
			# Enemigo impactado
			if (area.color == 2 && area.vida<=0):
				if (color == 0):
					get_parent().puntosP1+=area.lvl
				else:
					get_parent().puntosP2+=area.lvl
			queue_free()
