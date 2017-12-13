# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Panel

export (NodePath) var particulasPath
onready var nodoParticulas = get_node( particulasPath )
export (NodePath) var attractPath
onready var nodoAtractor = get_node( attractPath )
export (NodePath) var repelPath
onready var nodoRepulsor = get_node( repelPath )

onready var activo = get_node("HBoxContainer1/VBoxContainer/activo")
onready var ramp = get_node("HBoxContainer1/VBoxContainer/ramp")
onready var local = get_node("HBoxContainer1/VBoxContainer/local")
onready var campos = get_node("HBoxContainer1/VBoxContainer/campos")

onready var textura = get_node("HBoxContainer1/VBoxContainer1/textura")
onready var gravedad = get_node("HBoxContainer1/VBoxContainer1/gravedad")
onready var animacion = get_node("HBoxContainer1/VBoxContainer1/animacion")
onready var animacion1 = get_node("HBoxContainer1/VBoxContainer1/animacion1")

var degradado = null
var imagen = null

func _ready():
	activo.set_pressed(true)
	ramp.set_pressed(true)
	local.set_pressed(false)
	campos.set_pressed(false)

	textura.set_pressed(true)
	gravedad.set_pressed(false)
	animacion.set_pressed(false)
	animacion1.set_pressed(false)

	activo.connect("toggled",self,"cambiar")
	ramp.connect("toggled",self,"cambiar")
	local.connect("toggled",self,"cambiar")
	campos.connect("toggled",self,"cambiar")
	textura.connect("toggled",self,"cambiar")
	gravedad.connect("toggled",self,"cambiar")
	animacion.connect("toggled",self,"cambiar")
	animacion1.connect("toggled",self,"cambiar")

	degradado = nodoParticulas.get_color_ramp()
	imagen = nodoParticulas.get_texture()

	cambiar( null )

func cambiar( nuevo ):
	# Emisor activo.
	nodoParticulas.set_emitting(activo.is_pressed())

	# Degradado.
	if ( ramp.is_pressed() ):
		nodoParticulas.set_color_ramp(degradado)
	else:
		nodoParticulas.set_color_ramp(null)

	# Espacio local.
	nodoParticulas.set_use_local_space(local.is_pressed())

	# Campos.
	if ( campos.is_pressed() ):
		nodoAtractor.get_node("zonaCircular").show()
		nodoRepulsor.get_node("zonaCircular").show()
	else:
		nodoAtractor.get_node("zonaCircular").hide()
		nodoRepulsor.get_node("zonaCircular").hide()

	nodoAtractor.set_enabled(campos.is_pressed())
	nodoRepulsor.set_enabled(campos.is_pressed())

	# Textura.
	if ( textura.is_pressed() ):
		nodoParticulas.set_texture( imagen )
	else:
		nodoParticulas.set_texture( null )

	# Gravedad.
	if ( gravedad.is_pressed() ):
		nodoParticulas.set_param(Particles2D.PARAM_GRAVITY_STRENGTH,9.8)
	else:
		nodoParticulas.set_param(Particles2D.PARAM_GRAVITY_STRENGTH,0)

	nodoParticulas.get_node("AnimationPlayer").set_active(animacion.is_pressed())

	nodoAtractor.get_node("AnimationPlayer").set_active(animacion1.is_pressed())
	nodoRepulsor.get_node("AnimationPlayer").set_active(animacion1.is_pressed())
