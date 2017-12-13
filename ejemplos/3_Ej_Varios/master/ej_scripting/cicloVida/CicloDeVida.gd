# Introducción a Godot.
# Ejemplo de ciclo de vida de un Nodo.
# E.H.S.J - Nov 2017.


extends Node

# Finaliza el programa cuando alcance el estado de "listo".
export var terminador = false
var linea = ""

func _init():
	# Al no haber entrado en escena, todavia no podemos acceder al nombre ni a los exports del nodo.
	mostrar("_init","Inicio de la clase")

func _enter_tree():
	mostrar("_enter_tree","Entrada en árbol de escena.")

func _ready():
	mostrar("_ready","Instancia lista.")
	if (terminador):
		mostrar("get_tree().quit()","Salir del programa.")
		get_tree().quit()

func _exit_tree():
	mostrar("_exit_tree","Salir del árbol de escena.")

func mostrar(punto,descripcion):
	var nombreNodo = str(get_name())
	if (nombreNodo == ''):
		nombreNodo = "N/A"
	print(self,":\"",nombreNodo,"\"-> ",punto,", \"",descripcion,"\"")
