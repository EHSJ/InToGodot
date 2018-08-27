# ***Capítulo 2. Una Visión General de Godot***

Desarrollo de Juegos Multiplataforma Utilizando Godot Engine.

Proyecto final del ciclo formativo de grado superior en Desarrollo de Aplicaciones Multiplataforma. Cursado en el ***I.E.S. Augustóbriga*** de Navalmoral de la Mata,

Por Eugenio Hugo Salgüero Jáñez.

## ¿Qué es un Motor de juegos?

Motor de Videojuegos es un término que hace referencia al **conjunto de rutinas de programación**, específicas e independientes del contenido del juego, que **posibilitan** y facilitan el proceso de **diseño y creación** de un **videojuego**.

La funcionalidad básica de un motor es proveer al videojuego de un motor de _renderizado_ para los gráficos 2D y 3D, motor físico o detector de colisiones, sonidos, _scripting_, animación, inteligencia artificial, redes, streaming, administración de memoria y un escenario gráfico. El proceso de desarrollo de un videojuego puede variar notablemente por reutilizar o adaptar un mismo motor de videojuego para crear diferentes juegos.

## ¿Qué es Godot?

Godot es un motor de juegos **libre**, de **alto nivel de abstracción** y **multiplataforma**. Puede usarse para desarrollar juegos de muchos géneros diferentes gracias a su arquitectura versátil. Esta pensado tanto para juegos 2D como 3D y ofrece herramientas para adaptarse a todos los tamaños y proporciones de pantalla.

Originariamente creado por [Juan Linietsky] y Ariel Manzur a principios de 2008, ha sido usado para desarrollar multitud de juegos. En febrero de 2014 cambió a licencia **MIT** y alcanzó la versión 1.0 estable en diciembre del mismo año.

El desarrollo sigue liderado por los creadores originales, pero se está creando una fuerte comunidad alrededor del proyecto, que está trabajando en mejorar el motor. Desde Noviembre del 2015, Godot es un proyecto desarrollado por completo por la comunidad, financiado por la organización sin ánimo de lucro [Software Freedom Conservacy].

### Ventajas

Como motor de juegos libre y abierto, Godot tiene mucho que ofrecer, tanto a desarrolladores nóveles como experimentados.

- **Código fuente disponible y libre**. Permite saber exactamente qué se está ejecutando, escribir extensiones del motor y recompilar el motor mismo para los ajustes de un juego en concreto.
- **Desarrollo colaborativo**. Se puede participar en la mejora del motor.
- **Multiplataforma**. Dando soporte de forma oficial a GNU/Linux X11, Windows, Osx, Android, iOS, HTML5 y BlackBerry 10.
- Maduro. Basado en **siete años de desarrollo** por profesionales de la industria del videojuego, con trabajos comerciales publicados.
- **Preparado para equipos** de desarrollo. Énfasis en trabajo concurrente y distribución de tareas entre los miembros del equipo de desarrollo.

### Desventajas

Al no tener tanta implantación en el sector, como otras herramientas propietarias, la documentación existente es todavía escasa.

Su enfoque versátil, le hace favorecer las soluciones multipropósito antes que las que ofrezcan el máximo rendimiento.

### El nombre

Aunque los ejemplos nunca podrán exponer todas las posibilidades del motor, es siempre interesante ver que es lo que han hecho otros desarrolladores usándolo. Godot ya tiene un bonito porfolio, incluso siendo un programa relativamente nuevo, pues su primer lanzamiento como software libre data del 2014.

Algunas referencias de juegos comerciales publicados son:

#### Juego para Móviles (Android/iOS/BlackBerry): Ultimo Carnaval

Ultimo Carnaval es un juego de cartas con componentes RPG. Creado por Square Enix y Okam Studio, se publicó en 2014.

![UltimoCarnaval]

#### Juego para Tablets: Deponia

Aventura gráfica tipo “_poin’n’click_” creada para plataformas de escritorio utilizando un engine diferente a Godot por _Daedalic Entertainment_. Recientemente se ha utilizado Godot para portarla a  iPads en colaboración con _Okam Studio_.

![Deponia]

#### Juego para Consolas: The Mystery Team

The Mystery Team es un juego tipo puzzle de investigación creado en 2011 para Sony utilizando Godot exclusivamente, solamente está disponible en PSP.

![TheMysteryTeam]

#### Juego para Móviles (Android/BlackBerry): Anthill

Anthill es un juego de estrategia para Android y Blackberry.

![Anthill]

#### Games Jam

Desde que es software libre, Godot es utilizado frecuentemente en quedadas de desarrollo de unas horas o “Games Jam”.

Dolphin Island 2 es un ejemplo de una demo bien pulida creada en uno de estos eventos.

![DolphinIsland2]

#### Otros Juegos Libres

[Tanks of Freedom], distribuido bajo licencia MIT y vendido utilizando el modelo “ofrece un precio”. Es juego de estrategia por turnos que hace una utilización interesante de la paleta de 32 colores de la vieja escuela. Su fuente está disponible en: <https://github.com/w84death/Tanks-of-Freedom>

![TanksOfFreedom]

> Para consultar el porfolio de Godot puedes acceder a esta dirección: <https://godotengine.org/showcase>

## Componentes

### Engine Editor

El **editor** es el interfaz principal del motor. Se usa para establecer la propiedades del proyecto, las escenas, recursos y scripts e integra todo el contenido del juego. Está pensado para que sea usado por todos los miembros del equipo de desarrollo y en general para que todos integren sus trabajos directamente en el juego.

![editor_3d]

### Engine runtime

El _“runtime”_ es el código que ejecuta el contenido del juego creado por el editor. El contenido del juego es, generalmente, una colección de Scripts, escenas, texturas, modelos, sonidos, etc.. El _“runtime”_ simplemente carga una escena inicial y la ejecuta. A partir de ahí continúan esa escena y los scripts que la controlan.

### Plantillas de exportación

Estas plantillas son versiones compiladas del _“runtime”_ para cada plataforma soportada. Se utilizan para preparar la release final del juego y se pueden descargar en un paquete con todas las plataformas soportadas oficialmente.
Llegado el caso, si necesitamos más personalización de la aplicación final. Podemos recompilar estas plantillas a nuestro gusto.

## Instalación y Primer proyecto

### Descarga e instalación

Desde <https://godotengine.org/download> descargaremos

- El editor para nuestra plataforma. `Godot_v2.1.4-stable_<Plataforma>.zip`
- Los “Exports Templates”.  `Godot_v2.1.4-stable_export_templates.tpz`
- Los “Demos & Examples”. `Godot-Demos-2.1.4-stable.zip`
  
Los guardamos en nuestro repositorio de programas local. Ej: `/Descargas/Godot/` Y extraemos el único fichero del archivo del **editor** a una carpeta en nuestro directorio de programas.

Al estar empaquetado en un solo fichero, es fácil ir actualizando a las versiones nuevas del motor, simplemente copiando el ejecutable a la carpeta que usemos. Ej: `/Programas/Godot/` Que acabara conteniendo varios ejecutables cada uno con una versión diferente de Godot, permitiéndonos utilizar una u otra si observamos problemas de compatibilidad en algún proyecto concreto.

Los ajustes generales del programa, que no dependen de un proyecto concreto, se almacenan en “`\Users\[Usuario]\AppData\Roaming\Godot`” para windows y en “`/home/.godot`” bajo GNU.

El .zip de los Ejemplos podemos **descomprimirlo** a una carpeta de Ejemplos dentro de nuestros proyectos.

El .zip de los Templates lo abriremos más adelante desde el **editor** para añadirlo y así terminar la instalación. Hasta que no tengamos algo “hecho” no los vamos a necesitar.

### Configuración del Proyecto

Desde el punto de vista del productor, hacer un juego no es solamente tener una buena idea, sino hacerla real. Esto, a menudo, implica involucrar a varias personas (como poco alguien que programe y otra que haga el trabajo artístico). Conforme va aumentando el proyecto, las necesidades de organización se incrementan. A veces, desemboca en la necesidad de contar con un director de proyecto, o al menos algún tipo de acuerdo practico dentro del equipo.

En Godot, el primer concepto de organización es el Proyecto, que es básicamente un fichero de configuración que almacena algunas propiedades del juego.

#### Crear el proyecto

Lo primero que se muestra cuando lanzamos Godot es el “**Project Manager**”, que nos da acceso a todos los proyectos en los que estamos trabajando, pudiendo añadir nuevos o quitar de la lista los que no necesitemos. Para borrarlos definitivamente tendremos que utilizar el explorador de archivos de nuestro sistema.

![gestor_proyectos]

Desde el explorador dentro de Godot o desde el sistema, vamos a crear la carpeta del proyecto donde vamos a trabajar.

La configuración que me ha resultado más eficiente, clara y cómoda quedaría así para el proyecto de ejemplo “Hola Mundo”. Crearemos esta estructura:
`/Home/Proyecto HolaMundo/master`

Esta es la carpeta que seleccionaremos como destino a la hora de crear nuestro proyecto. Aquí se creará el fichero `engine.cfg`, que es el que reconoce Godot para saber donde se encuentra el directorio raíz de nuestro juego. Todo el contenido de esta carpeta se considerará contenido del juego y se empaquetará a la hora de hacer las releases, no es buena ideal guardar en este sitio las fuentes de recursos del juego, como los .psd o los .blend.
`/Home/Proyecto HolaMundo/base`

En esta carpeta guardaremos el contenido fuente del juego, como por ejemplo los archivos de imágenes en formato de nuestro editor preferido, los archivos de objetos en 3d, etc. Es a esta carpeta a donde iremos a buscar los archivos cuando importemos contenido al editor. Y recomiendo que sea hermana de la del proyecto, pues Godot busca actualizaciones en los ficheros que importemos mediante rutas relativas, sincronizando el contenido del juego con el de fuentes, cuando sea necesario. No es mala idea crear un documento de texto en esta carpeta donde detallemos la idea que queremos desarrollar junto con las notas que necesitemos así como documentos adicionales para coordinar el equipo si fuera necesario.
`/Home/Proyecto HolaMundo/releases`

Por último, aquí almacenaremos las versiones compiladas, queda a discreción de cada uno el uso de subcarpetas como `releases/v.09/Android/ARM` o `releases/GNU-Linux/v.09`

Esta estructura nos permite subir a un repositorio la carpeta raíz de nuestro trabajo `/Home/Proyecto HolaMundo`, sabiendo que las fuentes de los “assets” están dentro del control de versiones pero sin interferir con la carpeta de juego.

Para añadir los ejemplos que hemos descargado u otro proyecto anterior, basta con [[Escanear]] la carpeta raíz de los ejemplos o [[Importar]] el que nos interese.

Una vez creada la estructura de directorios anterior. Podemos pulsar [[Nuevo Proyecto]] e introducir la ruta, `/Home/Proyecto HolaMundo/master` , y el nombre de proyecto, `Hola Mundo`.

Hecho esto, el editor crea unos archivos en el directorio del juego. El fichero `engine.cfg`, un icono genérico `icon.png` y otro fichero de banderas, flags, para procesar el `icon.png`.

El contenido de `engine.cfg` es de texto plano y al momento de la creación del proyecto contendrá:

```cfg
[application]
name="Hola Mundo"
icon="res://icon.png"
```

Desde las [[opciones del proyecto]], en el editor. Podremos, mas adelante, cambiar el contenido de `engine.cfg`.

Con doble click en el proyecto, lo abrimos en el editor.

### Definir los ajustes del juego

Una vez abierto el editor, podemos cambiar las opciones del proyecto en _Escena > Configuración de Proyecto_.

![ajuste_proyecto]

Cada propiedad puede estar activada o no. Si no lo está se usará el valor por defecto, conservando el valor personalizado si se vuelve a activar.

En estas opciones se pueden tocar mil cosas, entre ellas si se iniciará en pantalla completa, el icono y el nombre del juego, que definimos a la creación. La resolución inicial, la `boot_splash_screen`, etc..

Estos ajustes se verán reflejados en el `engine.cfg`, aunque no sea necesario ni saberlo.

Es importante ser consecuente en como afectan las opciones del juego al funcionamiento del mismo, por ejemplo si utilizas pantalla completa has de pensar en como se adaptará el juego a diferentes aspectos de pantalla.

Señalar que Godot utiliza archivos de texto plano para todo si es posible. Por lo que resulta fácil utilizar sistemas como **git** o mercurial para el control de versiones.

### La estructura del proyecto

Godot está estructurado para maximizar la eficiencia del equipo de desarrollo. Cada miembro puede centrarse en una parte del juego sin estorbar al resto. Se ha hecho un esfuerzo adicional en eliminar el “cuello de botella del programador”. Esto es: que el programador tenga que estar implicado en realizar la integración de cada uno de los cambios.

Con el proyecto creado es momento de empezar a poblarlo. En Godot podemos resumir esto en: crear escenas, ponerlas juntas y hacer que sus elementos interactúen. La filosofía de trabajo comienza por crear las escenas de cada elemento individual del juego, haciendo que:

- Ayude a **clarificar** el proyecto.
- Haga los elementos **reutilizables**.
- Los elementos se puedan **modificar fácilmente**.
- Nos de la máxima **libertad para la estructura del juego**, particularmente para cambiar los principios del diseño, si fuese necesario. Esto facilita el **prototipado rápido** de aplicaciones.
- Cada escena sea un fichero independiente; hay menos riesgos de conflictos al usar sistemas colaborativos de control de versiones.

Para este propósito, divide tu juego en pequeñas partes y define como interactuarán. Por ejemplo, se necesitará un mundo que estará compuesto por varios objetos como un fondo, elementos que no sean el jugador, obstáculos, enemigos, etc.. Cada uno puede ser creado en una escena separada, incluso pueden ser subdivididos a su vez en otras escenas si son objetos complejos. El principio en el que nos basamos es: Haz más con menos, que deriva en: ***reutiliza, reutiliza y combina***.

Generalmente necesitaremos scripts para dotar de una funcionalidad básica a cada la escena.

### Organización de los archivos

Para empezar no hace falta darle muchas vueltas a este tema, podemos guardarlos todos en el directorio raíz y luego redistribuirlos cuando crezca el proyecto. Aún así:
Godot se sirve del sistema de ficheros del sistema operativo para organizar el directorio del proyecto y somos libres de elegir la distribución que queramos, aquí tienes las claves para pensar la que vas a usar:

- Godot detecta cualquier directorio que contenga el engine.cfg (incluso uno vacío), como un proyecto.
- Puedes agrupar los ficheros por función en el juego (nivel1,nivel2,jefe1…) o alternativamente puede hacerse por tipo de recurso (sprites, sonidos, sripts…).
- Las rutas son relativas. Si necesitas mover ficheros puedes utilizar la función de refactorizar [Renombrar o mover] del menú contextual del recurso para propagar las dependencias.

Partiendo de estas premisas hay quien ha establecido estas aproximaciones:

- Una carpeta para cada tipo de fichero.
  - **Fácil** para encontrar el recurso que buscas.
  - **Difícil** de migrar y reusar.
- Una carpeta para cada asset.
  - **Fácil** de reutilizar y de gestionar las dependencias.
  - Estructura de carpetas más profunda.
- Guardarlo todo dentro de escenas. (Como los .pak de Blender)
  - Un fichero por asset es **fácil** de gestionar.
  - **Difícil** de reutilizar y de actualizar los cambios de las fuentes.

La primera opción es mejor para el prototipado rápido de juegos, la segunda para proyectos “pulidos” y la tercera señala que es una técnica utilizada ampliamente para algunos assets, como un polígono en 2D, pintado dentro del editor y asociado a un __sprite__, para hacer su colisión, por ejemplo. Este polígono es un recurso que no está reflejado en un fichero independiente, pues estará dentro de un __sprite__ que será salvado en una escena. Nos recuerdan que no debemos guardar de esta manera datos binarios, osea una imagen, por ejemplo. Es que mejor tener ficheros separados a no ser que se trate de assets que sean “tal para cual” como el ejemplo de una imagen 2D (un __sprite__) y su polígono de colisión.

Siempre podremos utilizar la ***función de refactorizar*** a la hora de reestructurar el proyecto.

## El omnipresente Hola mundo

Siguiendo los pasos anteriores, Abrimos Godot y mediante [[Nuevo Proyecto]], abrimos el explorador de archivos, desde donde podemos crear la carpeta `/Proyecto Hola Mundo/master` que en realidad es la única que vamos a crear dada la sencillez del ejemplo. Y le ponemos el nombre al “Juego”.

Abrimos el proyecto y buscamos la pestaña [[Escena]]. Pulsamos en el símbolo [[+]]. Para añadir un objeto a la escena actual. Seleccionamos un `Label` dentro de la rama `Control`. Y pulsamos  [[Crear]] para añadirlo a la escena.

![add_nodo]

Con esto ya tenemos una escena con un objeto clase `Label` como raíz de la misma. 

Podríamos añadir un texto a la etiqueta desde el editor, tan simple como buscar la pestaña [[Inspector]] y editar el campo `Text`. Pero entonces no tocaríamos nada de código y el ejemplo quedaría demasiado estático. Vamos a establecer y actualizar el texto mediante un __script__.

Al pulsar botón derecho sobre nuestro `Label` en la pestaña [[Escena]], seleccionamos ***Agregar Script*** en el menú contextual y en la ventana de creación activamos ***Script Integrado***. La alternativa es seleccionar una ruta del directorio de juego y un nombre de fichero para el __script__. Pero lo vamos a dejar integrado para mantener el ejemplo lo mas compacto posible. De una manera u otra al aceptar se abrirá el modulo de [[Script]].

Podemos ver el código:

```gd
extends Label

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass
```

Lo primero que significa este código inicial es que extendemos de una `Label`, es decir, en este código **vamos a ser una etiqueta**. Por lo que podremos acceder a la propiedad `Text` de la que hablábamos antes, junto con todas las demás que tiene `Label` y sus ancestros.

Luego tenemos comentarios, que empiezan por ‘#’ que explican donde van las variables miembro y como declarar una.

Por último tenemos una función predefinida que se llama `_ready():`

En Godot cada Script se va ejecutando “cuando toca”, y cuando toca es cuando el bucle llamado “`main_loop`” le da paso. El “punto de entrada” en el script es la función `_ready`, la barra baja indica que es una f***unción virtual*** del sistema, de las que hay varias y hablaremos mas adelante. Cada una es llamada por el “`main_loop`” según avance el ciclo de vida del script.

`_ready` se ejecuta una sola vez. Y esta es cuando el **Nodo** que contiene el script esta “listo” para el juego. Es decir cuando se carga la escena que lo contiene y el **Nodo Label** en cuestión. Como verás esto es útil para inicializar variables. Pero no para actualizar cosas constantemente.

Tenemos claro que solo queremos establecer la propiedad Text en nuestra Label una sola vez, por lo que usaremos `_ready`. Dentro de la cual añadimos la linea:

```gd
set_text("Hola Mundo")
```
Podremos darle al botón de [[Play]] o a [[F5]] para ejecutar. No sin antes salvar la escena y establecer la ***Escena Inicial*** para el juego. Lo primero es fácil y lo segundo se encuentra en las Opciones del proyecto, pero de todas maneras al intentar ejecutar sin haberlo hecho nos guiará para que lo hagamos, primero una cosa y luego la otra. Y a la tercera vez de darle al [[Play]] se ejecutará.

---

<!-- Links -->

[Juan Linietsky]: https://twitter.com/reduzio
[Software Freedom Conservacy]: https://sfconservancy.org/

[Tanks of Freedom]: http://tof.p1x.in/ "Web oficial de Tanks of Freedom"
[UltimoCarnaval]: ./img/otrosJuegos/UltimoCarnaval.png "Ultimo Carnaval"
[Deponia]: ./img/otrosJuegos/Deponia.png "Deponia"
[TheMysteryTeam]: ./img/otrosJuegos/TheMysteryTeam.png "The Mystery Team"
[Anthill]: ./img/otrosJuegos/Anthill.png "Anthill"
[DolphinIsland2]: ./img/otrosJuegos/DolphinIsland2.png "Dolphin Island 2"
[TanksOfFreedom]: ./img/otrosJuegos/TanksOfFreedom.png "Tanks of Freedom"

<!-- Imágenes -->

[editor_3d]: ./img/editor/editor_3d.png "Editor Godot 2.x, pestaña 3D"
[gestor_proyectos]: ./img/editor/gestor_proyectos.png "Project Manager"
[ajuste_proyecto]: ./img/editor/editor_ajustes_proyecto.png "Ajustes de Proyecto"
[add_nodo]: ./img/editor/editor_add_nodo.png "Añadir Nodo"