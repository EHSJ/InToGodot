# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends RigidBody2D

enum {EXPOSICION, RECARGANDO, LISTO, SALIENDO, BUSCANDO, IMPULSO, FIJADO, DESACTIVADO}

export(int,"Exposición","Recargando","Listo","Saliendo","Buscando","Impulso","Fijado","Desactivado") var estado = 0
export(int,"ninguno","Negro","Rojo","Verde","Azul","Naranja") var equipo = 0

var vectorAvance = Vector2(0,0)
var vectorStrafe = Vector2(0,0)
var fuerzaGriro = 0
var aceleracionAplicada = Vector2(0,0)
var blanco = null
var tiempoImpulso = 5.0

func _ready():
	if ( estado == EXPOSICION || estado == RECARGANDO || estado == LISTO ):
		set_sleeping(true)
		get_node("infoDinamica").activo = false

	set_process(true)
	set_fixed_process(true)

func _process(delta):
	pass

func _fixed_process(delta):
	if ( estado == RECARGANDO || estado == LISTO ):
		set_rot(get_parent().get_rot())
	elif ( estado == SALIENDO ):
		set_sleeping(false)
		var salida = ( Vector2( 0, -200 )).rotated( get_rot() )
		apply_impulse( Vector2( 0, 0 ), salida )
		get_node("infoDinamica").activo = true
		estado = BUSCANDO
	elif ( estado == BUSCANDO ):
		vectorAvance = Vector2( 0, 0 )
		if ( blanco != null ):
			fuerzaGriro = 0
			estado == FIJADO
		elif ( tiempoImpulso <= 0 ):
			tiempoImpulso = 5.0
			estado = IMPULSO
		else:
			tiempoImpulso -= delta
	elif ( estado == IMPULSO ):
			if ( tiempoImpulso >0 ):
				tiempoImpulso -= delta
				fuerzaGriro = 0
				vectorAvance = ( Vector2( 0, -30 )).rotated( get_rot() )
			else:
				fuerzaGriro = 100
				tiempoImpulso = 5.0
				estado = BUSCANDO
	elif ( estado == FIJADO ):
		if ( blanco != null ):
			estado == BUSCANDO
		else:
			vectorAvance = ( Vector2( 0, -50 )).rotated( get_rot() )

	# Aplicar Cambios.
	aceleracionAplicada = vectorAvance + vectorStrafe
	set_applied_force(aceleracionAplicada)
	set_applied_torque ( fuerzaGriro )

func _on_Area2D_body_enter( body ):
	if ( body.is_in_group( "esBlancoMisil" ) && body.equipo != equipo ):
		print(get_name(),body.get_name()," entra.")
		blanco = body

func _on_Area2D_body_exit( body ):
	if ( body.is_in_group( "esBlancoMisil" ) && body.equipo != equipo ):
		print(get_name(),":",body.get_name()," sale.")
		blanco = null

func _on_Misil_body_enter( body ):
	if ( body.is_in_group( "vulnerable" ) ):
		if ( body.has_method( " impacto ")): body.impacto()
		self.queue_free()
