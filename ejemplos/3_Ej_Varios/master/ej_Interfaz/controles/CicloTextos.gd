# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Control

onready var etiqueta = get_node("lista/Label")
onready var linea = get_node("lista/LineEdit")

func _on_Button_pressed():
	var txt = etiqueta.get_text()
	etiqueta.set_text(linea.get_text())
	linea.set_text(txt)

