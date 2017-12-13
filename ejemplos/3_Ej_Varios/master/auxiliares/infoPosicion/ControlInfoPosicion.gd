# Introducción a Godot.
# InfoPosicion
# Etiqueta muestra texto con posición del Bisabuelo.
# 	Que será la Camara o un Objeto 2D.
# E.H.S.J - Nov 2017.

extends Label

# Enlace al Bisabuelo, cuando este listo.
onready var bisabuelo = get_node("../../..")

func _ready():
	if (bisabuelo.has_method("get_pos")):
		# Establecer el proceso en cada imagen.
		set_process(true)
	else:
		print("Esta escena no puede ejecutarse sola,\nanidala a un objeto 2D para que muestre su posición.")

func _process(delta):
	# Actualizar la equiteta con la posición.
	set_text(str(bisabuelo.get_pos()))

