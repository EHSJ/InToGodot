
extends Sprite
var dam1
var dam2
var dam3

func _ready():
	dam1=load("res://jugador/naves/dam1.png")
	dam2=load("res://jugador/naves/dam2.png")
	dam3=load("res://jugador/naves/dam3.png")
	set_process(true)

func _process(delta):
	var vida=get_parent().vida
	if(vida>90):
		set_texture(null)
	elif(vida>75):
		set_texture(dam1)
	elif(vida>50):
		set_texture(dam2)
	elif(vida<25):
		set_texture(dam3)

