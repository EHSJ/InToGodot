extends Particles2D
var p
func _ready():
	set_emitting(true)
	p=get_parent()
	pre_process(true)
