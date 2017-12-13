extends AcceptDialog

func _ready():
	self.connect("about_to_show",self,"_on_AcercaDe_about_to_show")

func _on_AcercaDe_about_to_show():
	get_node("AnimationPlayer").play("AparecerTexto")
