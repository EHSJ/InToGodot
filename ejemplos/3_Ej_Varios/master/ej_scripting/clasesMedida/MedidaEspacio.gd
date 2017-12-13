# Introducción a Godot.
# Clase medida Espacio
# Alamacena una medida espacial independiente de la unidad.
# E.H.S.J - Nov 2017.
#
# 	Unidades Soportadas:
# 		Sistema Internacional:
#			mm	->	milímetro.
#			cm	->	centímetro.
#			m	->	metro.
#			km	->	kilómetro.
# 		Sistema Imperial:
#			in	->	pulgada.
#			ft	->	pié.
#			yd	->	yarda.
#			mi	->	milla imperial.
#			nm	->	milla naútica.
#	Vistas:
#		ME_NATIVA: Cadena con la unidad original.
#		ME_DEBUG: Todas las Unidades, tabuladas.
#		ME_SI: Unidad mas grande en el Sistema Internacional.
#		ME_IMPERIAL: Unidad mas grande en el Sistema Imperial.
#		ME_ALTITUD: La muestra en pies.
#		ME_NAVEGACION: La muestra en Millas Naúticas.

# Unidades:
enum {ME_MM,ME_CM,ME_M,ME_KM,ME_IN,ME_FT,ME_YD,ME_MI,ME_NM}

# Constantes de conversión.
const ME_MM_M = 0.001
const ME_CM_M = 0.01
const ME_KM_M = 1000
const ME_IN_M = 0.254
const ME_FT_M = 0.3048
const ME_YD_M = 9.144
const ME_MI_M = 1609.344
const ME_NM_M = 1852

const marcaNativa ="*"

# Vistas:
enum {ME_NATIVA,ME_DEBUG,ME_SI,ME_IMPERIAL,ME_ALTITUD,ME_NAVEGACION}

# Variables de Clase.
var nombre
var origen
var mm setget setMm
var cm	setget setCm
var m	setget setM
var km	setget setKm
var inch setget setIn
var ft	setget setFt
var yd	setget setYd
var mi	setget setMi
var nm	setget setNm

## Constructor:
#	traduce de la cadena "unidad" y llama a su setter.
func _init(valor, unidad, nombre):
	self.nombre = nombre
	# Creada usando una cadena para la unidad.
	if (typeof(unidad) == TYPE_STRING):
		if (unidad == "mm"):
			self.mm = valor
		elif (unidad == "cm"):
			self.cm = valor
		elif (unidad == "m"):
			self.m = valor
		elif (unidad == "km"):
			self.km = valor
		elif (unidad == "in"):
			self.inch = valor
		elif (unidad == "ft"):
			self.ft = valor
		elif (unidad == "yd"):
			self.yd = valor
		elif (unidad == "mi"):
			self.mi = valor
		elif (unidad == "nm"):
			self.nm = valor
		else:
			print ("Error 01 al crear la unidad de Espacio: Unidad Desconocida.")
	# Usando el enum.
	elif (typeof(unidad) == TYPE_INT):
		if (unidad == ME_MM):
			self.mm = valor
		elif (unidad == ME_CM):
			self.cm = valor
		elif (unidad == ME_M):
			self.m = valor
		elif (unidad == ME_KM):
			self.km = valor
		elif (unidad == ME_IN):
			self.inch = valor
		elif (unidad == ME_FT):
			self.ft = valor
		elif (unidad == ME_YD):
			self.yd = valor
		elif (unidad == ME_MI):
			self.mi = valor
		elif (unidad == ME_NM):
			self.nm = valor
		else:
			print ("Error 02 al crear la unidad de Espacio: Unidad Desconocida.")

## Actualiza las unidades.
func actualizar():
	mm = m / ME_MM_M
	cm = m / ME_CM_M
	km = m / ME_KM_M
	inch = m / ME_IN_M
	ft = m / ME_FT_M
	yd = m / ME_YD_M
	mi = m / ME_MI_M
	nm = m / ME_NM_M

func sum(sumando):
	self.mm += sumando.mm

func mostrar(vista):
	if (vista == ME_NATIVA):
		if (origen == ME_MM):
			return strMm() + marcaNativa
		elif (origen == ME_CM):
			return strCm() + marcaNativa
		elif (origen == ME_CM):
			return strCm() + marcaNativa
		elif (origen == ME_M):
			return strM() + marcaNativa
		elif (origen == ME_KM):
			return strKm() + marcaNativa
		elif (origen == ME_IN):
			return strIn() + marcaNativa
		elif (origen == ME_FT):
			return strFt() + marcaNativa
		elif (origen == ME_YD):
			return strYd() + marcaNativa
		elif (origen == ME_MI):
			return strMi() + marcaNativa
		elif (origen == ME_NM):
			return strNm() + marcaNativa
		else:
			print ("Error al mostrar la unidad de Espacio:# 1")
	elif (vista == ME_DEBUG):
		var formato = "%s= %s= %s= %s= %s= %s= %s= %s= %s [%s]"
		var resultado = formato % [strMm(),strCm(),strM(),strKm(),strIn(),strFt(),strYd(),strMi(),strNm(),mostrar(ME_NATIVA)]
		return nombre +": "+ resultado
	elif (vista == ME_SI):
		if km >= 1:return strKm()
		if m >= 1:return strM()
		return strCm()
	elif (vista == ME_IMPERIAL):
		if nm >= 1:return strNm()
		if mi >= 1:return strMi()
		if yd >= 1:return strYd()
		return strFt()
	elif (vista == ME_ALTITUD):
		return strFt()
	elif (vista == ME_NAVEGACION):
		return strNm()

## GETTERS:
#	 Unidades a Cadena
func strMm():return "%.0f mm." % mm
func strCm():return "%.1f cm." % cm
func strM():return "%.1f m." % m
func strKm():return "%.2f km." % km
func strIn():return "%.1f in." % inch
func strFt():return "%.0f ft." % ft
func strYd():return "%.1f yd." % yd
func strMi():return "%.2f mi." % mi
func strNm():return "%.2f nm." % nm

## SETTERS:
#	Establecen el origen y actualizan el valor de los metros.
func setMm (valor):
	origen = ME_MM
	m = valor * ME_MM_M
	actualizar()
func setCm (valor):
	origen = ME_CM
	m = valor * ME_CM_M
	actualizar()
func setM (valor):
	origen = ME_M
	m = valor
	actualizar()
func setKm (valor):
	origen = ME_KM
	m = valor * ME_KM_M
	actualizar()
func setIn (valor):
	origen = ME_IN
	m = valor * ME_IN_M
	actualizar()
func setFt (valor):
	origen = ME_FT
	m = valor * ME_FT_M
	actualizar()
func setYd (valor):
	origen = ME_YD
	m = valor * ME_YD_M
	actualizar()
func setMi (valor):
	origen = ME_MI
	m = valor * ME_MI_M
	actualizar()
func setNm (valor):
	origen = ME_NM
	m = valor * ME_NM_M
	actualizar()
