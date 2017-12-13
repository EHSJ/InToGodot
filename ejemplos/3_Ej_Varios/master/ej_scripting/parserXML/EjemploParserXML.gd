# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Node

func _ready():
	var data = XMLParser.new()
	data.open("res://Ejemplos/EjemploParserXML/misiles.sxml")
	var c = 0
	while (c != 18):
		c = data.read()
		var tipo = data.get_node_type()
		var nombre = data.get_node_name()
		var texto = ""
		if (tipo == 3):
			texto = data.get_node_data()
		var numAtributos = data.get_attribute_count()
		var dicAtributos={}
		for idx in range(numAtributos):
			var nombre = data.get_attribute_name(idx)
			var valor = data.get_attribute_value(idx)
			dicAtributos[nombre]=str(valor)

		print(str(c) +": "+ tipo_str(tipo) +" "+ nombre +" "+ texto +" "+ str(numAtributos))
		yield(get_tree(), "idle_frame")

	yield(get_tree(), "idle_frame")
	get_tree().quit()

func tipo_str(tipo):
	if (tipo==0):
		return "NONE"
	elif (tipo==1):
		return "ELEMENT"
	elif (tipo==2):
		return "ELEMENT_END"
	elif (tipo==3):
		return "TEXT"
	elif (tipo==4):
		return "COMMENT"
	elif (tipo==5):
		return "CDATA"
	elif (tipo==6):
		return "UNKNOWN"
