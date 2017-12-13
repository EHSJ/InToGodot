# Scroll par un fondo infinito.
# -E.H. Salgüero Jáñez	12/08/2016
# 1 Situar y Ajustar el mirroring del ParallaxLayer.
# 2 Estructura:
#	ParallaxBackground
#		ParallaxLayer <este script>
#			TextureFrame <imagen del scroll>
#			mas imágenes..
#		mas capas de scroll..

extends ParallaxLayer

# Variables expuestas en el editor
export(int) var velocidad=100
export(int,"Arriba","Derecha","Abajo","Izquierda") var direccion=1
export(int) var mirroring =256

## Esta función se ejecuta en cuanto se ha cargado este nodo.
func _ready():
	# Activar la función _process(delta)
	set_process(true)

## Esta función es el bucle principal de la clase.
func _process(delta):
	# Obtener posición.
	var posicion=get_pos()
	# Mover en Dirección.
	if(direccion==0): #Arriba
		posicion.y-=velocidad * delta
		if(posicion.y<=-mirroring):posicion.y=0
	elif(direccion==1): #Derecha
		posicion.x-=velocidad * delta
		if(posicion.x<=-mirroring):posicion.x=0
	elif(direccion==2): #Abajo
		posicion.y+=velocidad * delta
		if(posicion.y>=0):posicion.y=-mirroring
	elif(direccion==3): #Izquierda
		posicion.x-=velocidad * delta
		if(posicion.x<=-mirroring):posicion.x=0
	# Establecer nueva posición.
	set_pos(posicion)


