# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends RigidBody2D

enum {EXPOSICION, LISTA, SALIENDO, BUSCANDO, FIJADA, DESACTIVADO}

export(String) var nombre = "Sin Nombre"
export(int,"Exposición","Recargando","Listo","Saliendo","Buscando","Fijado","Desactivado") var estado = 0
export(int,"ninguno","Negro","Rojo","Verde","Azul","Naranja") var equipo = 0

onready var laser = load( "res://elementos/objetos/Laser.tscn" )

# Puntuaciones de la nave:
var puntuacion = {
	escudo = 0,
	bateria = 0,
	potenciaMotor = 0,
	potenciaStrafe = 0,
	capacidadGiro = 0
	}

# Stats de la nave:
export var stats = {
	escudo = { maximo = 100, actual = null},
	bateria = { maximo = 300, actual = null},
	motorAvance = { maximo = 500, actual = null},
	turbo = { maximo = 700, actual = null, enfriamientoMax = 2, enfriamiento = 0.0 },
	motorStrafe = { maximo = 300, actual = null},
	motorGiro = { maximo = 15000, actual = null},
	disparoA = { tipo = 0, enfriamientoMax = 0.2, enfriamiento = 0 },
	disparoB = { tipo = 0, municion = 2, enfriamientoMax = 3.0, enfriamiento = 0 }
	}

# Estructura de Ordenes:
#	valor: tiene un rango de -1 a 1.
var ordenes = {
	avance = { valor = 0, estado = false },
	strafe = { valor = 0, estado = false },
	giro = { valor = 0, estado = false },
	turbo = { estado = false },
	parar = { estado = false },
	disparoA = { estado = false },
	disparoB = { estado = false, municion = 0.0 }
	}

var vectorAvance = Vector2(0,0)
var vectorStrafe = Vector2(0,0)
var fuerzaGriro = 0.0
var aceleracionAplicada = Vector2(0,0)

var turboEnfriamiento = 0.0

func inicializarNave():
	stats.escudo.actual = stats.escudo.maximo
	stats.bateria.actual = stats.bateria.maximo
	stats.motorAvance.actual = stats.motorAvance.maximo
	stats.turbo.actual = stats.turbo.maximo
	stats.motorStrafe.actual = stats.motorStrafe.maximo
	stats.motorGiro.actual = stats.motorGiro.maximo

func actualizarPuntuacionesNave():
	puntuacion.potenciaMotor = stats.motorAvance.maximo / get_mass()
	puntuacion.potenciaStrafe = stats.motorStrafe.maximo / get_mass()
	puntuacion.capacidadGiro = stats.motorGiro.maximo / get_mass()
	print(get_name(),": Stats: Motor: ",puntuacion.potenciaMotor," Strafe: ",puntuacion.potenciaStrafe," Giro: ",puntuacion.capacidadGiro )

func _ready():
	inicializarNave()
	actualizarPuntuacionesNave()
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	# Orden de Avance:
	if ( ordenes.avance.valor != 0 ):
		ordenes.avance.valor = clamp( ordenes.avance.valor, -1, 1 )
		ordenes.avance.estado = true
		# Calcula el vector de aceleración.
		vectorAvance = ( Vector2( 0, -stats.motorAvance.actual )*ordenes.avance.valor).rotated( get_rot() )
		if ( ordenes.avance.valor < 0 ):
			vectorAvance /= 2
	elif ( ordenes.avance.estado ) :
		ordenes.avance.estado = false
		vectorAvance = Vector2(0,0)
	# Orden de Movimiento Lateral (Strafe):
	if ( ordenes.strafe.valor != 0 ):
		ordenes.strafe.valor = clamp ( ordenes.strafe.valor, -1, 1)
		ordenes.strafe.estado = true
		# Calcula el vector de strafe.
		vectorStrafe = (Vector2( stats.motorStrafe.actual, 0 )*ordenes.strafe.valor).rotated( get_rot() )
	elif ( ordenes.strafe.estado ):
		ordenes.strafe.estado = false
		vectorStrafe = Vector2(0,0)
	# Orden de Giro:
	if ( ordenes.giro.valor !=0 ):
		ordenes.giro.valor = clamp( ordenes.giro.valor, -1, 1)
		ordenes.giro.estado = true
		# Calcula el par de torsión a aplicar.
		fuerzaGriro = stats.motorGiro.actual * ordenes.giro.valor
	elif ( ordenes.giro.estado ):
		ordenes.giro.estado = false
		fuerzaGriro = 0
	# Orden Parar:
	if ( ordenes.parar.estado == true ):
		set_linear_damp( .5 )
		set_angular_damp( 5 )
	else:
		set_linear_damp( -1 )
		set_angular_damp( 1 )
	# Orden de Turbo:
	if ( ordenes.turbo.estado == true && stats.turbo.enfriamiento == 0 ):
		if ( stats.turbo.enfriamiento == 0 ):
			var vectorTurbo = ( Vector2( 0, -stats.turbo.actual )).rotated( get_rot() )
			apply_impulse( Vector2( 0, 0 ), vectorTurbo )
			stats.turbo.enfriamiento = stats.turbo.enfriamientoMax
	else:
		if ( stats.turbo.enfriamiento > 0 ): stats.turbo.enfriamiento -= delta
		elif ( stats.turbo.enfriamiento < 0 ): stats.turbo.enfriamiento = 0
	# Disparo A:
	if ( ordenes.disparoA.estado  == true ):
		if ( stats.disparoA.enfriamiento == 0 ):
			stats.disparoA.enfriamiento = stats.disparoA.enfriamientoMax
			print( stats.disparoA.enfriamiento )
			var tmp = laser.instance()
			tmp.configurar( self )
			get_tree().get_root().add_child(tmp)
	if ( stats.disparoA.enfriamiento > 0 ): stats.disparoA.enfriamiento -= delta
	elif ( stats.disparoA.enfriamiento < 0 ): stats.disparoA.enfriamiento = 0


func _fixed_process(delta):
	# Aplicar Cambios.
	aceleracionAplicada = vectorAvance + vectorStrafe
	set_applied_force(aceleracionAplicada)
	set_applied_torque ( fuerzaGriro )

