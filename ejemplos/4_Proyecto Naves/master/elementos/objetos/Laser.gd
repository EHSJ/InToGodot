# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Area2D

export(int,"ninguno","Negro","Rojo","Verde","Azul","Naranja") var equipo = 0
export(int,"Pequeño","Medio","Pesado") var tipo = 0
var naveOrigen
var poder							# Daño que hace.
var vectorAvance = Vector2( 0, 0)
var velocidad = 10 					# Pixels/s
var tiempo = 10.0 					# Segundos de vida del disparo.

# Hace las funciones de constructor, se ha de llamar cuando se crea
# la instancia desde una nave. Si se crea el disparo en el editor, no.
func configurar( naveO ):
	# Establece la posición y el ángulo de la nave q lo dispara.
	naveOrigen = naveO
	set_rot( naveO.get_rot() )
	set_pos( naveO.get_pos() )

func _ready():
	if ( tipo == 0 ):
		poder = 1
		get_node("SpriteS").show()
	if ( tipo == 1 ):
		poder = 5
		get_node("SpriteM").show()
	if ( tipo == 2 ):
		poder = 10
		get_node("SpriteL").show()

	vectorAvance += ( Vector2( 0, -velocidad )).rotated( get_rot() )
	set_fixed_process( true )

func _fixed_process(delta):
	set_pos(get_pos()+vectorAvance)

func _on_Laser_body_enter( body ):
	if ( body != naveOrigen && body.is_in_group( "vulnerable" ) ):
		if ( body.has_method( "impacto" )): body.impacto(poder)
		self.queue_free()
