extends Control

var sel = 0
var op = [null,null,null]
var key = false


func _ready():
	op[0]=get_node("menu/op-1/Sprite")
	op[1]=get_node("menu/op-2/Sprite")
	op[2]=get_node("menu/op-3/Sprite")
	actualiza()
	set_process(true)

func _process(delta):
	if(Input.is_action_pressed("ui_cancel")):
#		salir()
		pass
	elif(Input.is_action_pressed("ui_up")):
		if(!key):
			sel -= 1
			key = true
			actualiza()
	elif(Input.is_action_pressed("ui_down")):
		if(!key):
			sel += 1
			key = true
			actualiza()
	elif(Input.is_action_pressed("ui_accept")):
		if (sel==2):salir()
		else: iniciar(sel+1)
	else:
		key = false

func actualiza():
	# Gestion de limites
	if (sel < 0):
		sel = 2
	elif (sel > 2):
		sel = 0
	# Gráficos.
	for i in range (3):
		if (i == sel):
			op[i].show()
		else:
			op[i].hide()

func iniciar(p):
	var escenaActual = get_tree().get_root().get_child(get_tree().get_root().get_child_count() -1)
	var partida = preload ("res://partida/partida.tscn").instance()
	partida.jugadores=p
	get_tree().get_root().call_deferred("add_child",partida)
	escenaActual.queue_free()

func salir():
	get_tree().quit()


