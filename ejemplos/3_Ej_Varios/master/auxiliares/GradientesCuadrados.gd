# Introducción a Godot.
# E.H.S.J - Nov 2017.

tool
extends CanvasItem

export(int,16,1024,8) var resolucion = 32 setget set_resolucion
export(int,"Rojo-Verde","Rojo-Azul","Verde-Azul") var colores = 1 setget set_colores
export(float,0,1,0.1) var restante = 0.5 setget set_restante

func set_resolucion(nueva):
	resolucion = nueva
	texturizar()

func set_colores(nuevo):
	colores = nuevo
	texturizar()

func set_restante(nuevo):
	restante = nuevo
	texturizar()

func texturizar():
	var valorH
	var valorV
	var imagen = Image(resolucion,resolucion,false,Image.FORMAT_RGB)
	for x in range(0,resolucion):
		for y in range(0,resolucion):
			valorH = float(x)/resolucion
			valorV = float(y)/resolucion

			if (colores == 0):
				imagen.put_pixel(x,y,Color(valorH,valorV,restante),0)
			elif (colores == 1):
				imagen.put_pixel(x,y,Color(valorH,restante,valorV),0)
			elif (colores == 2):
				imagen.put_pixel(x,y,Color(restante,valorH,valorV),0)

	var textura = ImageTexture.new()
	textura.create_from_image(imagen,ImageTexture.FLAGS_DEFAULT)
	set_texture(textura)
