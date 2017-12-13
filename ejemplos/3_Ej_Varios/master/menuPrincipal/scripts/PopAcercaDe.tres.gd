# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends AcceptDialog

func _ready():
	self.connect("about_to_show",self,"_on_AcercaDe_about_to_show")

func _on_AcercaDe_about_to_show():
	get_node("AnimationPlayer").play("AparecerTexto")

func _on_Titulo_meta_clicked( meta ):
	print ( "A")
	print( meta )
