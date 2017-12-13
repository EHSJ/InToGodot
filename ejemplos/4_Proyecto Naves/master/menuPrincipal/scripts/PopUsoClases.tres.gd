extends AcceptDialog

func _ready():
	self.connect("about_to_show",self,"_on_UsoDeClases_about_to_show")

func _on_UsoDeClases_about_to_show():
	var pruebaMedida = load ("res://ej_scripting/clasesMedida/EjemploMedida.tscn")
	add_child(pruebaMedida.instance() )