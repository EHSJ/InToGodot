
extends Sprite

func _ready():
	set_process(true)

func _process(delta):
	var escalaY=get_parent().get_parent().velocidad/get_parent().get_parent().velocidadMax
	set_scale(Vector2(1,escalaY))
