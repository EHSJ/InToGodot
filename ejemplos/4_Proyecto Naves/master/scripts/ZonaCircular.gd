# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Sprite

var radio = 0
export (Color) var cBorde = Color(1,.6,1,.2)
export (Color) var cRelleno = Color(.5,.5,.5,.1)

func _ready():
	radio = get_parent().get_shape().get_radius()

func _draw():
	draw_circle_arc(get_pos(),radio,0,360,cBorde,3)
	draw_circle(get_pos(),radio,cRelleno)

func draw_circle_arc( center, radius, angle_from, angle_to, color, grosor ):
	var nb_points = angle_to - angle_from
	var points_arc = Vector2Array()
	for i in range(nb_points+1):
		var angle_point = angle_from +i*(angle_to-angle_from)/nb_points - 90
		var point = center + Vector2( cos(deg2rad(angle_point)),sin(deg2rad(angle_point)))*radius
		points_arc.push_back(point)

	for i in range(nb_points):
		draw_line(points_arc[i],points_arc[i+1],color,grosor)
