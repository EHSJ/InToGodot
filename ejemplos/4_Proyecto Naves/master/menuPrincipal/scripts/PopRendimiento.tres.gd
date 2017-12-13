extends AcceptDialog

onready var barraFps = get_node("Panel/ProgressBar")
onready var slideFps = get_node("Panel/SliderFps")
onready var labelTasa = get_node("Panel/LabelTasa")
onready var labelFps = get_node("Panel/ProgressBar/fpsLabel")
onready var labelInfo = get_node("Panel/Info")
onready var checkMax = get_node("Panel/CheckMax")
onready var checkVsync = get_node("Panel/CheckVsync")
onready var checkEco = get_node("Panel/CheckEco")

export var rate = 0.5
var ultimo = 0.0
var fps = 0
var fpsTarget = 60

func _ready():
	# Configurar controles.
	barraFps.set_max( fpsTarget + ( fpsTarget/8 ) )
	slideFps.connect( "value_changed",self,"_on_sliderFps_value_changed" )
	labelTasa.set_text( "Tasa objetivo: " + str( fpsTarget ) + " fps." )
	checkMax.connect( "toggled",self,"_on_checkMax_toggled" )
	checkEco.set_pressed( OS.is_in_low_processor_usage_mode() )
	checkEco.connect( "toggled",self,"_on_CheckEco_toggled" )
	checkVsync.set_pressed( OS.is_vsync_enabled() )
	checkVsync.connect( "toggled",self,"_on_CheckVsync_toggled" )

	self.connect("about_to_show",self,"_on_Rendimiento_about_to_show")


func _process(delta):
	# Actualizar el contador fps, cada rate.
	if ( ultimo > rate ):
		ultimo -= rate
		fps = OS.get_frames_per_second()
#		print ( fps )
		barraFps.set_value( fps )
		labelFps.set_text( str(fps) + " fps, (max:" + str(fpsTarget)+ ")" )
	else:
		ultimo += delta

func _on_Rendimiento_about_to_show():
	# Crear el texto de información.
	var texto = "Corriendo en un sistema de Ventanas tipo [color=green]" + OS.get_name()
	texto += "[/color]. Con un procesador de [color=green]"+str( OS.get_processor_count() )
	texto += "[/color] núcleos."
	if ( OS.can_use_threads() ):
		texto += " Que puede utilizar multihilo.\n"
	else:
		texto += "Que [color=red]no[/color] puede utilizar multihilo.\n"
#	texto += str( OS.get_screen_count() ) + ".\n"
#	texto += str( OS.get_screen_dpi(0) ) + ".\n"
#	texto += str( OS.get_video_mode_size() ) + ".\n"
#	texto += str( OS.get_model_name() ) + ".\n"
	# Aplicar el texto con formato.
	labelInfo.parse_bbcode( texto )

	set_process(true)

func _on_CheckVsync_toggled( pressed ):
#	print( "VSync!" )
	OS.set_use_vsync( pressed )

func _on_CheckEco_toggled( pressed ):
#	print( "Eco!" )
	OS.set_low_processor_usage_mode( pressed )

func _on_sliderFps_value_changed( value ):
#	print( OS.get_target_fps() )
	fpsTarget = value
	barraFps.set_max( fpsTarget + ( fpsTarget/4 ) )
	OS.set_target_fps( fpsTarget )
	checkMax.set_pressed( false )
	labelTasa.set_text( "Tasa objetivo: " + str( fpsTarget ) + " fps." )

func _on_checkMax_toggled( pressed ):
	if ( pressed ):
		fpsTarget = 9999
		checkVsync.set_pressed( false )
		OS.set_use_vsync( false )
		checkEco.set_pressed( false )
		OS.set_low_processor_usage_mode( false )
	else:
		fpsTarget = slideFps.get_value()
	labelTasa.set_text( "Tasa objetivo: " + str( fpsTarget ) + " fps." )
	barraFps.set_max( fpsTarget + ( fpsTarget/4 ) )
	OS.set_target_fps( fpsTarget )
