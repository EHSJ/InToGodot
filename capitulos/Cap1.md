# Desarrollo de Juegos Multiplataforma Utilizando Godot Engine

Proyecto final del ciclo formativo de grado superior en Desarrollo de Aplicaciones Multiplataforma. Cursado en el ***I.E.S. Augustóbriga*** de Navalmoral de la Mata,

Por Eugenio Hugo Salgüero Jáñez.

## ***Capítulo 1. Introducción***

---

En este último curso hemos empezado a trabajar con un entorno orientado al desarrollo de juegos. Hemos visto el funcionamiento de un motor bajo _Java_, como es _jMonkey_ y hemos realizado una tarea con uno de los que cuenta con mayor implantación en el sector: Unity, que es una gran suite para el desarrollo de juegos multiplataforma. Pero por desgracia, no es libre, aunque ofrece una versión con funcionalidad limitada como "cebo" y ha conseguido amasar una nutrida comunidad de usuarios en los últimos años.

La programación de juegos es una rama de la informática que siempre me ha interesado. He probado varios motores en estos años, como [DIV Game Studio] (1998) y su sucesor libre [BennuGd] (2007), el motor integrado en la suite [Blender] (2005), Blender Game Engine, [Ogre] (2008), [Unity] (2010) .. Como he podido comprobar hay multitud de alternativas para este tipo desarrollo: Algunas utilizando otro lenguaje “huésped” como jMonkey, otras implementando binarios nativos para cada plataforma, como Unity. Pero son pocas las que ofrecen todas las funciones que necesitamos en un solo paquete, teniendo que recurrir muchas veces a bibliotecas de terceros.

Con la aparición de las nuevas herramientas que integran render 3d de alta calidad y motores de física bajo un mismo entorno, el proceso se ha vuelto más universal y han eclosionado multitud de estudios amateur o “indie” para desarrollar sus proyectos. Como todos los comienzos en una nueva tecnología, **nos hará adoptar costumbres y maneras de pensar adaptadas a la herramienta** que utilicemos. Y aunque en Unity es fácil empezar, cuando progresamos con los proyectos cada vez vamos topando con más funciones restringidas, lo que muchas veces acaba con la instalación de versiones crackeadas, lo cual acaba siendo un contratiempo independientemente de la actitud ética que se tenga respecto a la libertad del Software o los derechos de autor.

Es para resolver esta cuestión que surgió _Godot_ Engine que ofrece un IDE Integrado, 2D, 3D, físicas, iluminación, pathfinding, **multiplataforma en NATIVO**. Utiliza GLES (OpenGl) y aunque el render de la versión actual es bastante bueno, no llega a los niveles del, por ejemplo, Unreal Engine. En Unity para conseguir ese detalle de representación también se recurre a plugins de “pago”. De todas formas en la siguiente versión de Godot, la 3.0 se implementa GLES3.0 lo que supondría equipararse en calidad gráfica a las alternativas privativas.

Aunque la comunidad está haciendo un gran esfuerzo por actualizar la documentación, especialmente para la próxima versión, mucha de la disponible para la actual es muy somera o está incompleta, por lo que es habitual tener que recurrir a la prueba y error o directamente a escudriñar el código fuente del motor para aclarar algunos aspectos. Facilitar a todos aquellos interesados en la programación en general y en el desarrollo de juegos en particular, una itinerario de aprendizaje y una guía de referencia es el **objetivo de este proyecto**.

> Este Documento está en constante evolución, y gran parte de el es una traducción libre de las fuentes citadas, comprobadas por el autor y modificadas para la versión 2.1.4. Los ejemplos que se incluyen están creados exprofeso para este manual y las capturas también se han hecho para la ocasión.

Cáceres.
Diciembre 2017

## Descripción y Objetivos del proyecto

---

“Desarrollo de juegos multiplataforma utilizando _Godot Engine_.” es el proyecto final del alumno Eugenio Hugo Salgüero Jáñez para el ciclo formativo de grado superior en Desarrollo de Aplicaciones Multiplataforma. Cursado en el I.E.S. Augustóbriga de Navalmoral de la Mata, Cáceres.

Está compuesto por un documento con formato de manual y varios proyectos para Godot 2.1.4

Tiene como objetivo fomentar e introducir en la creación de software de entretenimiento multiplataforma, utilizando únicamente software libre.

Se trataran los siguientes temas:

- La **instalación y configuración** de la herramienta.
- Creación y **estructura del proyecto** de trabajo.
- **Compilación** para diferentes plataformas, como Android, X11, Windows…
- Funcionamiento del lenguaje **GDScript**.
- Descripción de los **Nodos más utilizados** del motor.
- Compendio de **herramientas y recursos** libres.

## Descripción del contenido

La obra se estructura en una parte teórica, consistente en **seis capítulos y cuatro anexos**. Junto con un parte practica compuesta de **cinco proyectos en Godot**.

El primer capítulo de la parte teórica contiene el **propósito, objetivos y descripción del proyecto**.

En el segundo se **describe la tecnología**, su historia y características generales, su naturaleza interpretada y se presentan algunos proyectos, comerciales y aficionados, realizados con ella. Finaliza explicando los pasos a seguir desde la **descarga** hasta tener nuestro **primer proyecto** `01_Hola Mundo`.

El tercero hace un repaso general por la **interfaz del Editor**, sus **ajustes de configuración** y los atajos de teclado. También se explican las principales **propiedades del proyecto**.

En el cuarto se presenta **GDScript**, el lenguaje principal de Godot. Será la **guía de referencia** para consultar la sintaxis o funcionalidades concretas. Al final se explican las peculiaridades del **tipado dinámico**, que utilizaremos. Como ejemplo de uso de clases, en el Anexo 01, se tratará la declaración, instanciación y operación de una clase auxiliar, para el tratamiento de longitudes.

En el quinto entraremos en los conceptos del **funcionamiento interno** y los recursos que pone el motor a nuestra disposición para ahorrarnos trabajo. A los conceptos de **nodo** y **escena** les siguen el tratamiento de rutas a los recursos y el uso de **señales y detección de entradas** ya sean de teclado, ratón o dispositivos de juego, el concepto de árbol de escena y de BuclePrincipal.  Nuestros nodos colgaran de ese árbol y los scripts serán ejecutados atendiendo a las **funciones virtuale**s que tengan implementados. La gestión de capas (`Canvas`) y de puntos de vista también se tratará así como los diferentes **sistemas de referencia** para las coordenadas. La adaptación de nuestro programa a las diferentes **resoluciones de pantalla** también se tratan en este capítulo. Puedes ampliar los conocimientos sobre este tema en el Anexo 02, con capturas de pantalla para los diferentes ajustes relacionados con la resolución de juego.

El sexto está dedicado al desglose y utilización de los diferentes Nodos que tenemos a nuestra disposición. Empezando por la clase `Control`, para la **interfaz de usuario**, donde se tratan los botones y textos, así como su alineación y **anclaje** en un marco flexible. Seguiremos con la clase `Node2D` responsable de la mayoría del contenido de nuestro proyecto, como los `Sprites`, sistemas de **partículas** y elementos del **motor de físicas**. El tercer proyecto de ejemplo “`03 Ejemplos Varios`” contiene las escenas a las que hace referencia este capítulo.

El Anexo 03 contiene un listado de Software libre y de repositorios de recursos online.

El Anexo 04 abordará algunos aspectos de los dos proyectos de ejemplo con temática espacial. Un sencillo, “`04B Matamarcianos DAM`” que fue objetivo de una tarea en la asignatura de Programación Multimedia y Dispositivos Móviles. Y un remake del juego [SpaceWar!], al que hemos denominado “`04 Guerra Espacial`” Se ha elegido este último por la idoneidad para implementarlo con el motor de físicas de Godot y así poder ejemplificar las diferentes funciones que tiene. El motivo de incluir en este proyecto, un trabajo ya entregado, como es “Matamarcianos DAM”, no es otro que permitir al lector acceder a unas técnicas, como la reproducción de sonidos, creación de un menú principal, etc.. que no han podido ser incluidas en la presente obra por falta de tiempo, pues se ha priorizado añadir contenido nuevo.

## Licencia

Esta obra está acogida bajo una licencia: ***Reconocimiento-No Comercial-CompartirIgual***.

Esta licencia permite a otros entremezclar, ajustar y construir a partir de esta obra con fines no comerciales, siempre y cuando le reconozcan la autoría y sus nuevas creaciones estén bajo una licencia con los mismos términos.

|**Reconocimiento-NoComercial-CompartirIgual 4.0 Internacional**|
|:-:|
|<https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode>|
|![CC4]|

---

[DIV Game Studio]: https://es.wikipedia.org/wiki/DIV_Games_Studio
[BennuGd]: http://www.bennugd.org/es
[Blender]: https://www.blender.org/
[Ogre]: https://www.ogre3d.org/
[Unity]: https://unity3d.com/
[SpaceWar!]: https://es.wikipedia.org/wiki/Spacewar!

[CC4]: ./img/cc.png
