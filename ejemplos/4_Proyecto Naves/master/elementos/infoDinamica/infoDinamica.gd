# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Sprite

onready var padre = get_parent()

export (bool) var activo = true
export (Color) var colCentro = Color(1,1,0,.3)
export (Color) var colVelocidad = Color(1,1,0,.3)
export (Color) var colControlAvance = Color(.2,.5,.9,.3)
export (Color) var colControlStrafe = Color(.2,.5,.9,.3)
export (Color) var colFuerzaAplicada = Color(1,.2,.2,.3)
export (float) var anchoLinea = 3.0
export (float) var escala = 1.0

var padrePropulsado = false

func _ready():
	set_process(true)
	if ( padre.is_in_group("mostrarPropulsado")):
			padrePropulsado = true

func _process(delta):
	set_global_rot(0)
	update()

func _draw():
	if ( activo ):
		draw_circle(Vector2(), anchoLinea*escala*2, colCentro)
		dibujar_linea(padre.get_linear_velocity(), Vector2(), escala, colVelocidad)
		dibujar_linea(padre.get_applied_force(), Vector2(), escala, colFuerzaAplicada)
		if ( padrePropulsado ):
			dibujar_linea(padre.vectorAvance, Vector2(), escala, colControlAvance)
			dibujar_linea(padre.vectorStrafe, Vector2(), escala, colControlStrafe)

func dibujar_linea(vector, pos, scale, color):
	if vector.length() == 0:
		return
	draw_line(pos * scale, vector * scale, color, anchoLinea)
	var dir = vector.normalized()
	dibujar_flecha(vector * scale, dir, anchoLinea*2, color)
	draw_circle(pos, anchoLinea/2, color)

func dibujar_flecha(pos, dir, size, color):
	var a = pos + dir * size
	var b = pos + dir.rotated(2*PI/3) * size
	var c = pos + dir.rotated(4*PI/3) * size
	var points = Vector2Array([a, b, c])
	draw_polygon(points, ColorArray([color]))
