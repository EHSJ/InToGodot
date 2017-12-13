# Introducción a Godot.
# Clase medida Masa
# Alamacena una medida de masa independiente de la unidad.
# E.H.S.J - Nov 2017.
#
# 	Unidades Soportadas:
# 		Sistema Internacional:
#			gr	->	gramo.
#			kg	->	kilogramo.
#			tm	->	tonelada métrica.
# 		Sistema Imperial:
#			st	->	tonelada corta (US.)
#			lt	->	tonelada larga (UK.)
#			lb	->	libra avoirdupois.
#			oz	->	onza avoirdupois.
#	Vistas:
#		ME_NATIVA: Cadena con la unidad original.
#		ME_DEBUG: Todas las Unidades, tabuladas.
#		ME_SI: Unidad mas grande en el Sistema Internacional.
#		ME_IMPERIAL: Unidad mas grande en el Sistema Imperial.

# Unidades:
enum {MM_GR,MM_KG,MM_TM,MM_ST,MM_LT,MM_LB,MM_OZ}

# Constantes de conversión.
const MM_GR_KG = 0.001
const MM_TM_KG = 1000
const MM_ST_KG = 907.18474
const MM_LT_KG = 1016.0469088
const MM_LB_KG = 0.45359237
const MM_OZ_KG = 0.28349523125

const marcaNativa ="*"

# Vistas:
enum {ME_NATIVA,ME_DEBUG,ME_SI,ME_IMPERIAL}

# Variables de Clase.
var nombre
var origen
var gr	setget setGr
var kg	setget setKg
var tm	setget setTm
var st	setget setSt
var lt	setget setLt
var lb	setget setLb
var oz	setget setOz

func _init(valor, unidad,nombre):
	self.nombre = nombre
	if (unidad == "gr"):
		self.gr = valor
	elif (unidad == "kg"):
		self.kg = valor
	elif (unidad == "tm"):
		self.tm = valor
	elif (unidad == "st"):
		self.st = valor
	elif (unidad == "lt"):
		self.lt = valor
	elif (unidad == "lb"):
		self.lb = valor
	elif (unidad == "oz"):
		self.oz = valor
	else:
		print ("Error al crear la unidad de Masa :# 1")

func actualizar():
	gr = kg / MM_GR_KG
	tm = kg / MM_TM_KG
	st = kg / MM_ST_KG
	lt = kg / MM_LT_KG
	lb = kg / MM_LB_KG
	oz = kg / MM_OZ_KG

func sum(sumando):
	self.kg += sumando.kg

func mostrar(vista):
	if (vista == ME_NATIVA):
		if (origen == MM_GR):
			return strGr() + marcaNativa
		elif (origen == MM_KG):
			return strKg() + marcaNativa
		elif (origen == MM_TM):
			return strTm() + marcaNativa
		elif (origen == MM_ST):
			return strSt() + marcaNativa
		elif (origen == MM_LT):
			return strLt() + marcaNativa
		elif (origen == MM_LB):
			return strLb() + marcaNativa
		elif (origen == MM_OZ):
			return strOz() + marcaNativa
		else:
			print ("Error al mostrar la unidad de Masa:# 1")
	elif (vista == ME_DEBUG):
		var formato = "%s = %s = %s = %s = %s = %s = %s [%s]"
		var resultado = formato % [strGr(),strKg(),strTm(),strSt(),strLt(),strLb(),strOz(),mostrar(ME_NATIVA)]
		return nombre +": "+ resultado

## GETTERS:
#	 Unidades a Cadena
func strGr():return "%.0f gr." % gr
func strKg():return "%.0f kg." % kg
func strTm():return "%.1f tm." % tm
func strSt():return "%.1f st." % st
func strLt():return "%.1f lt." % lt
func strLb():return "%.0f lb." % lb
func strOz():return "%.0f oz." % oz

## SETTERS:
#	Establecen el origen y actualizan el valor de los Kilos.
func setGr (valor):
	origen = MM_GR
	kg = valor * MM_GR_KG
	actualizar()
func setKg (valor):
	origen = MM_KG
	kg = valor
	actualizar()
func setTm (valor):
	origen = MM_TM
	kg = valor * MM_TM_KG
	actualizar()
func setSt (valor):
	origen = MM_ST
	kg = valor * MM_ST_KG
	actualizar()
func setLt (valor):
	origen = MM_LT
	kg = valor * MM_LT_KG
	actualizar()
func setLb (valor):
	origen = MM_LB
	kg = valor * MM_LB_KG
	actualizar()
func setOz (valor):
	origen = MM_OZ
	kg = valor * MM_OZ_KG
	actualizar()
