# Introducción a Godot.
# E.H.S.J - Nov 2017.

extends Panel

export (NodePath) var particulasPath
onready var nodoParticulas = get_node( particulasPath )
export (NodePath) var panelBanderasPath
onready var panelBanderas = get_node( panelBanderasPath )

export (Texture) var texturaPruebas = null
export (ColorRamp) var degradadoPruebas = null

export (Texture) var texturaFuego = null
export (ColorRamp) var degradadoFuego = null

export (Texture) var texturaHumo = null
export (ColorRamp) var degradadoHumo = null

func _on_BotonFuego_pressed():

	panelBanderas.ramp.set_pressed(true)
	panelBanderas.textura.set_pressed(true)

	panelBanderas.imagen = texturaFuego
	panelBanderas.degradado = degradadoFuego

	nodoParticulas.set_texture(texturaFuego)
	nodoParticulas.set_color_ramp(degradadoFuego)

#	nodoParticulas.set_use_local_space(true)
#	nodoParticulas.set_param(Particles2D.PARAM_LINEAR_VELOCITY,10)
#	nodoParticulas.set_param(Particles2D.PARAM_GRAVITY_STRENGTH,0)
#	nodoParticulas.set_param(Particles2D.PARAM_SPIN_VELOCITY,1)
#	nodoParticulas.set_param(Particles2D.PARAM_SPREAD,15)
#	nodoParticulas.set_param(Particles2D.PARAM_INITIAL_SIZE,0.2)
#	nodoParticulas.set_param(Particles2D.PARAM_FINAL_SIZE,1.5)
#
#	nodoParticulas.set_randomness(Particles2D.PARAM_LINEAR_VELOCITY,1)
#	nodoParticulas.set_randomness(Particles2D.PARAM_SPIN_VELOCITY,1)
#	nodoParticulas.set_randomness(Particles2D.PARAM_SPREAD,1)
#	nodoParticulas.set_randomness(Particles2D.PARAM_INITIAL_SIZE,1)
#	nodoParticulas.set_randomness(Particles2D.PARAM_FINAL_SIZE,1)

func _on_BotonHumo_pressed():

	panelBanderas.ramp.set_pressed(true)
	panelBanderas.textura.set_pressed(true)

	panelBanderas.imagen = texturaHumo
	panelBanderas.degradado = degradadoHumo

	nodoParticulas.set_texture(texturaHumo)
	nodoParticulas.set_color_ramp(degradadoHumo)

func _on_BotonPruebas_pressed():

	panelBanderas.ramp.set_pressed(true)
	panelBanderas.textura.set_pressed(true)

	panelBanderas.imagen = texturaPruebas
	panelBanderas.degradado = degradadoPruebas

	nodoParticulas.set_texture(texturaPruebas)
	nodoParticulas.set_color_ramp(degradadoPruebas)
