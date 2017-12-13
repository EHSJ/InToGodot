# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends AcceptDialog

export (String,FILE) var escena

func _ready():
	self.connect("about_to_show",self,"_on_Anclas_about_to_show")

func _on_Anclas_about_to_show():
	get_node("AnimationPlayer").play("AparecerTexto")

func _on_Button_pressed():
	ControlesGenerales.cambiarEscena( escena )
