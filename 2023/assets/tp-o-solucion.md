# El alambique viajero

- Enunciado [acá](https://docs.google.com/document/u/1/d/e/2PACX-1vTpecrFHsM1-sH4kyp5Rt8RljpZig-XgHCjVh9oTZDcL6zBpTmG4OTb9SqPgIQvLQL6QSX0LfPvV5Gb/pub)
- Solución propuesta [acá](https://github.com/pdepjm/2023-o-alambique-veloz)

### ¿Cómo resolverlo? 
¡Hola! Esta es una guía del TP de objetos, con el objetivo de guiar a la solución propuesta y ver errores comunes que pueden aparecer en el camino. Pueden existir soluciones diferentes, este documento plantea una posible.

Luego de leer todo el enunciado, podemos comenzar por la primera parte, que nos pide concretamente qué tiene que poder cumplir nuestro sistema:

> **Averiguar**
> 1. Cuántos lugares visitó Luke
> 2. El recuerdo que se trajo del último lugar que visitó

Con esto, nos da una idea de lo que posiblemente queremos poder consultar. En otras palabras, sabemos que mensajes son los _principales_ y quién debería contestarlos: `Luke`. Queremos poder hacer:

```wollok
luke.cantidadLugaresVisitados()
>>> 5
luke.ultimoRecuerdo()
>>> "llavero"
```

Esto cumple con los dos puntos que nos pide el enunciado, ¡ahora hagamos que funcione! Se puede ver a simple vista con lo que pensamos hasta ahora que necesitamos:

- Un objeto llamado luke
- Que ese objeto entienda dos mensajes: `cantidadLugaresVisitados` y `ultimoRecuerdo`

Planteamos entonces esta estructura, luego la vamos completando de a poco:

```wollok
object luke{
  method cantidadLugaresVisitados()

  method ultimoRecuerdo()
}
```

¿Qué tiene que hacer `cantidadLugaresVisitados`? ¿Es de **consulta** o de **efecto**? ¡De **consulta**! Queremos que este método nos **devuelva** un número, concretamente la cantidad de lugares a los que viajo.
Sabemos gracias al resto del enunciado que Luke va a poder hacer un viaje (veremos más adelante), asi que tiene sentido que esa cantidad de lugares vaya cambiando con el paso del tiempo, ya que con cada viaje que haga, vamos a tener que sumarle 1 a este valor.
Entonces agreguemosle un atributo a Luke, y hagamos que este método sea un _getter_, es decir nos devuelva el valor de dicho atributo. Luego veremos cómo incrementarlo.

```wollok
object luke{
  var cantidadLugaresVisitados = 0
  method cantidadLugaresVisitados() = cantidadLugaresVisitados

  method ultimoRecuerdo()
}
```

#### ⚠ Error común 

Ja, tengo un atributo y necesito el **getter**. ¡uso `property` y me ahorro escribir el método!:

```wollok
object luke{
  var property cantidadLugaresVisitados = 0

  method ultimoRecuerdo()
}
```

Este es un error muy común y que representa un **error conceptual** que nos interesa evaluar. Repasemos qué hacía esta herramienta.

El `property` lo que hace es darnos tanto el **getter** como el **setter**, es decir que permite que **externamente** se pueda leer y modificar el atributo (es decir parte del **estado intero**) de mi objeto.

¿Qué pasa entonces? El estado interno de un objeto, es justamente **interno**, vamos a querer que la menor cantidad de objetos externos puedan tener acceso a modificarlos o leerlos. A este concepto le llamamos **encapsulamiento**, 
poner setters y getters cuando no son estrictamente necesarios implica **romper el encapsulamiento**, y justamente poner el **property** sin un análisis de si necesito **ambos** (setter y getter) implica que no
sabemos analizar el encapsulamiento de un objeto.

¿Entonces no usamos el `property`? Si lo podemos usar, pero _analizando_ cuando lo queremos y cuando no:

- ¿Necesito tener solo el getter? Hago un método getter a mano - **no uso property**
- ¿Necesito tener solo el setter? Hago un método setter a mano - **no uso property**
- ¿No necesito ninguno de los dos? **No uso property**
- ¿Necesito tanto el getter como el setter? Puedo hacer el método getter y el método setter a mano, pero también puedo ahorrarme eso y usar property

En este caso, por el momento solo nos interesa poder **consultar desde afuera** la cantidad de lugares que visitó, todavía no sabemos si necesitamos poder cambiarlo desde afuera (y spoiler, no vamos a querer esto), asi que nos quedamos con esta solución:

```wollok
object luke{
  var cantidadLugaresVisitados = 0
  method cantidadLugaresVisitados() = cantidadLugaresVisitados

  method ultimoRecuerdo()
}
```

#### Volviendo al ejercicio

Sigamos con el método `ultimoRecuerdo`, para esto necesitamos recordar qué nos dice el enunciado sobre los recuerdos:
> Cuando viaja se trae un recuerdo típico del lugar visitado que conserva en un lugar destacado de su casa. El problema es que su casa es pequeña, por lo que tira el recuerdo que haya traído de algún viaje anterior. 

Sobre los recuerdos nos dicen que cambia cuando viaja, pero no se guarda todos si no que guarda uno solo -> ¡podemos guardarlo en un atributo! 

```wollok
object luke{
  var cantidadLugaresVisitados = 0
  var ultimoRecuerdo = ""

  method cantidadLugaresVisitados() = cantidadLugaresVisitados

  method ultimoRecuerdo() = ultimoRecuerdo
}
```

Ya tenemos los métodos que necesitabamos para lo que nos pedía el enunciado. Pero nos hablan también de la idea de que Luke pueda **viajar**, veamos qué otra información nos dan sobre esto:
> El vehículo utilizado para viajar sufre las consecuencias. Cuando pretende visitar una ciudad a la que no puede ir, simplemente no va.

Por lo que leímos, viajar implica las siguientes cosas:
- El vehiculo con el que viaja sufre consecuencias.
- Sumamos en 1 a la _cantidad de lugares visitados_, ya que justamente visitamos un lugar al viajar
- Nos cambia el último recuerdo, siendo este el recuerdo típico de la ciudad a la que viajó

Y además de esto tenemos que tener en cuenta qué
- Hay ciudades a las cuales no puede ir, por lo que no siempre va a viajar

Son un montón de cosas 🤯, pensemos primero cómo lo usaríamos en la consola, ¿quién va a viajar? ¡Luke! Entonces tiene sentido que en la consola hagamos algo como:

```wollok
>>> luke.viajar()
```

Pero nos hablan de ciudades, es decir que no siempre viaja al mismo lugar -> es algo que va a ser diferente cada vez que enviemos el mensaje ¡usemos un parámetro entonces!

```wollok
>>> luke.viajarA(ciudad)
```

Ahora podemos ver más claro que necesitamos que Luke entienda el mensaje `viajarA`, dandole una ciudad a la cual viajar -> ¡tenemos que definir un método! ¿De efecto o de consulta? Si analizamos la lista que vimos antes sobre las cosas que debían ocurrir cuando se viajaba, apuntan a que son cosas que cambian estado, por lo que tiene sentido por ahora que sea un método de efecto.

```wollok
object luke{
  var cantidadLugaresVisitados = 0
  var ultimoRecuerdo = ""

  method cantidadLugaresVisitados() = cantidadLugaresVisitados

  method ultimoRecuerdo() = ultimoRecuerdo

  method viajarA(ciudad){
    //solo viajar si puede
    //el vehiculo tiene consecuencias
    //sumar cantidad de lugares visitados
    //cambiar ultimo recuerdo
  }
}
```

#### ⚠ Variante 

Algunas personas pueden haberlo modelado a `luke` y a la `casa` como dos objetos diferentes, y que uno de los dos le envíe un mensaje al otro para cambiar su estado al viajar (por ejemplo que Luke le pida a la casa que guarse su recuerdo). Podría ser una solución válida, y sería interesante si la csas tuviera algun valor agregado a solo guardar los valores, pero dado que no tiene más complejidad que esa, podemos simplemente dejar esto como atributos de Luke y simplificar las cosas.

#### Volviendo al ejercicio
Sumar la cantidad es algo que sale rápido, ya que tenemos un atributo que guarda esto, simplemente podemos aumentarlo en 1: 

```wollok
method viajarA(ciudad){
  //solo viajar si puede
  //el vehiculo tiene consecuencias
  cantidadLugaresVisitados = cantidadLugaresVisitados + 1
  //cambiar ultimo recuerdo
}
```

Cambiar el último recuerdo también suena como algo sencillo, es solo hacer `ultimo recuerdo = algo` ¿no? ¿Pero ese `algo` que es? Viendo cómo sigue el enunciado:

>Se conocen los siguientes recuerdos
> - El recuerdo típico de París es un llavero de la torre eiffel
> - Buenos Aires tiene como recuerdo típico un mate, pero dependiendo de quién sea el presidente puede venir con yerba o no.
> - etc

Vemos que cada una de las ciudades tiene un recuerdo diferente, entonces una opción para solucionar esto es ¡preguntarle a la ciudad!

```wollok
method viajarA(ciudad){
  //solo viajar si puede
  //el vehiculo tiene consecuencias
  cantidadLugaresVisitados = cantidadLugaresVisitados + 1
  ultimoRecuerdo = ciudad.recuerdo()
}
```

De esta forma, nos despreocupamos si a futuro tenemos muchas más ciudades posibles, siempre y cuando tengan un recuerdo podemos agregar muuchas más y nuestro código sigue funcionando. 

Estamos planteando con esto: `ciudad.recuerdo()` que las ciudades serán **objetos** que compartan una interfaz: el mensaje `recuerdo`. Las veremos más adelante pero nos sirve ya comenzar a pensar en ellas como objetos.

#### ⚠ Error común 

Otra forma de modelar esta parte es usando _strings_ para representar las ciudades y hacer varios `ifs`:

```wollok
method viajarA(ciudad){
  ...//resto de código
  if(ciudad == "buenos aires"){
    ultimoRecuerdo = "mate"
  }else if(ciudad == "paris"){
    ultimoRecuerdo = "llavero"
  }else if{
    ...//etc
  }
}
```

El problema de esto es que estamos limitando bastante a las ciudades, habiendo leído el enunciado podemos ver que hay más cosas que dependen de las ciudades, por lo que significa que tenerlas como strings nos ata a plagar nuestro código de `ifs` anidados cada vez que tengamos algo que dependa de ellas.
Además de esto, caemos en que no es tan fácil agregar nuevas ciudades, agregar una implicaría cambiar todos estos ifs.

En lugar de esto, la opción que presentamos **usando polimorfismo** nos permite que mientras las nuevas ciudades entiendan el mensaje polimorfico `recuerdo`, ¡no cambiemos nada!

#### Volviendo al ejercicio

Siguiendo con el método `viajarA` que dejamos a la mitad, nos queda completar que solo viaje si puede, ¿qué significa esto? Leamos un poco más el enunciado:

> Para poder ir a las ciudades, hay diferentes restricciones en las que interviene el vehículo que maneja Luke.
> - París, el alambique veloz tiene que tener el tanque de combustible lleno
> - Buenos Aires, el alambique veloz tiene que ser rápido
> - Bagdad no hay restricciones
> - Las Vegas: la misma restricción del lugar que se esté homenajeando

Estas restricciones, implican que si no cumplen con ellas, no deberíamos _viajar_, es decir que no deberíamos ni cambiar el recuerdo, ni sumar un lugar visitado, ni hacer que el vehiculo tenga consecuencias (que veremos más adelante). Suena a que necesitamos que esto solo se cumpla, si se cumple cierta condición ¡necesitamos una alternativa condicional!

```wollok
method viajarA(ciudad){
  if(/*una condicion*/){
    //el vehiculo tiene consecuencias
    cantidadLugaresVisitados = cantidadLugaresVisitados + 1
    ultimoRecuerdo = ciudad.recuerdo()
  }
}
```

Hacemos que estas tres cosas sucedan unicamente cuando la condición se cumple. ¿Cuál es la condición? Por lo que leímos recién, depende **de cada ciudad**, ¡y las ciudades son objetos! Es decir que podemos **delegar** esto a ellas, de la misma forma que hicimos con el recuerdo:

```wollok
method viajarA(ciudad){
  if(ciudad.puedeViajar()){
    //el vehiculo tiene consecuencias
    cantidadLugaresVisitados = cantidadLugaresVisitados + 1
    ultimoRecuerdo = ciudad.recuerdo()
  }
}
```

#### ⚠ Error común 

Utilizar ifs anidados para saber por cada ciudad si puede o no viajar, cae en el mismo problema mencionado antes con el recuerdo, nos conviene usar una solución con **polimorfismo**, que a luke no le interese cómo implementa cada ciudad la restricción, si no que justamente sea responsabilidad de las ciudades.

#### Volviendo al ejercicio

¿Pero con eso ya está la condición? 🤔 Leímos que en las restricciones interviene el vehiculo que esté usando Luke, que por lo que nos plantea la consigna hasta el momento es el Alambique Veloz. 
El vehículo, además, vemos que sufre consecuencias -> ¿quizás también es un objeto? Podemos definir el Alambique Veloz como un objeto, empezar a enviarle mensaje y más adelante vemos si nos sirve o no, si nos alcanza o no. 

```wollok
object luke{
  var cantidadLugaresVisitados = 0
  var ultimoRecuerdo = ""

  method cantidadLugaresVisitados() = cantidadLugaresVisitados

  method ultimoRecuerdo() = ultimoRecuerdo

  method viajarA(ciudad){
    if(ciudad.puedeViajar()){
      alambiqueVeloz.viajar()
      cantidadLugaresVisitados = cantidadLugaresVisitados + 1
      ultimoRecuerdo = ciudad.recuerdo()
    }
  }  
}
```

Ya que estamos, podemos delegar un poco más la lógica de este método, de forma que nos quede más _declarativo_. Lo que debería ocuparse `viajarA` es de _realizar el viaje_ si es que _puede hacerlo_, entonces podemos delegar la lógica de **realmente realizar el viaje** (hacer que el vehiculo viaje, etc) a otro método:

```wollok
object luke{
  var cantidadLugaresVisitados = 0
  var ultimoRecuerdo = ""

  method cantidadLugaresVisitados() = cantidadLugaresVisitados

  method ultimoRecuerdo() = ultimoRecuerdo

  method viajarA(ciudad){
    if(ciudad.puedeViajar())
      self.realmenteViajar() //es un mensaje de Luke, uso self entonces
  }

  method realmenteViajar(){
      alambiqueVeloz.viajar()
      cantidadLugaresVisitados = cantidadLugaresVisitados + 1
      ultimoRecuerdo = ciudad.recuerdo()
  }  
}
```

¡Tenemos a Luke! Cumple con lo que nos pide el enunciado, pero todavía nos está faltando codear las ciudades y al Alambique Veloz; pero habiendo hecho primero a Luke, partiendo del problema principal, hicimos un montón de análisis que ya nos sirve para saber por ejemplo que las ciudades son objetos y que necesitan entender los mensajes `recuerdo` y `puedeViajarCon`, ¡es un montón!

#### ⚠ Error común 

Un modelado que surgió con este TP fue hacer que las **ciudades** se encargaran de cambiar la cantidad de lugares visitados y el ultimo recuerdo de Luke. Esto nos trae dos problemas ligados a la repetición de lógica:

- Al repetirlo en todas las ciudades (porque siempre sucede, por ende todas las ciudades deberían repetirlo), si queremos cambiar algo en esa lógica, como decir que el último recuerdo es siempre "chocolate", hay que recordar que hay que cambiarlo en **toooodas** las ciudades (bastante engorroso).
- Estamos atandonos a recordar que si agregamos nuevas ciudades, hay que agregar que cambien el estado de este otro objeto que a primera vista no vemos qué tiene que ver -> resulta en código confuso de escalar.

Tanto el último recuerdo y la cantidad de lugares visitados son parte del estado propio de Luke, por lo que tiene sentido que la responsabilidad de hacer estos cambios sea de ese objeto. 

Por otro lado, queremos que todos estos cambios se realicen al enviar un solo mensaje, si no nos atamos a que viajar implica enviar varios mensajes a varios objetos, es decir algo como:

```wollok
>>>luke.viajar()
>>>ciudad.viajar()
>>>alambiqueVeloz.viajar()
```

¿Qué pasa si me olvido de ejecutar uno de esos comandos? Mi sistema ya no es consistente, es preferible hacerlo solo con un mensaje, y justamente el objeto que más sentido tiene que lo haga es Luke.

#### Volviendo al ejercicio

Como dijimos, ya sabemos que las ciudades necesitan dos mensajes para funcionar polimorficamente con Luke:

- `recuerdo`
- `puedeViajar`

Hagamos entonces el código necesario. Podemos empezar con `Paris` del cual sabemos que:

- Su recuerdo es un llavero de la torre eiffel
- Luke puede viajar con su vehiculo, que es el Alambique Veloz, dependiendo de tiene el tanque lleno -> como dijimos que era un objeto, podemos tomar la decisión de que entienda el mensaje `tieneTanqueLLeno`, que luego podemos codear

Entonces, podemos definir el objeto y los métodos:

```wollok
object paris{
	method recuerdo() = "llavero"
	method puedeViajar() = alambiqueVeloz.tieneTanqueLleno()
}
```

Luego tenemos a Buenos Aires, del cual sabemos que:

- Su recuerdo depende de quién es el presidente, es siempre un mate pero puede o no ir con yerba.
- Luke puede viajar si el vehiculo en que viaja, o sea el Alambique Veloz, es rápido. Como es un objeto que ya tenemos definido, le podemos enviar un mensaje para preguntarse si es rápido, al que denominamos precisamente `esRapido` y luego codearemos.

```wollok
object buenosAires{
	var presidente = "Pepita"

	method recuerdo() = "mate" + if(presidente == "Pepita") " con yerba" else ""
	method puedeViajar() = alambiqueVeloz.esRapido()
}
```

Tenemos también a Bagdad, del cual sabemos:

- Su recuerdo va cambiando con los años -> podemos guardarlo entonces en un atributo y que se cambie en el momento que deba cambiarse.
- No tiene restricciones -> ¡Ojo! Tiene que entender el mensaje igual, ya que comparte la interfaz de ser una _ciudad_, y luke va a preguntar de todas formas si puede o no. En este caso decimos que **siempre puede**, ya que no tiene restricciones

```wollok
object bagdad{
	var recuerdo = "bidon con petroleo crudo"

	 //getter
	method recuerdo() = recuerdo
	
	//setter
	method recuerdo(nuevoRecuerdo){
	recuerdo = nuevoRecuerdo
	}
	
	method puedeViajar() = true //no tiene restricciones
}
```

Pará pará pará... Vos me dijiste que si necesitaba el setter y el getter podía usar `property` -> en este caso sí:

- El getter es **necesario** ya que Luke va a preguntar por el recuerdo
- El setter es **necesario** ya que nos dicen que puede ir cambiando con los años, es decir que queremos poder cambiarlo desde el exterior del objeto.

¡Usemos property entonces!

```wollok
object bagdad{
	var property recuerdo = "bidon con petroleo crudo"
	
	method puedeViajar() = true //no tiene restricciones
}
```

Por último tenemos a Las Vegas:

- Su recuerdo depende del pais que esté homenajeando en el momento
- Su restriccion es la misma que el país que esté homenajeando en el momento

La ciudad que esté homenajeando suena a algo que queremos guardarnos, ya que de esta va a depende el comportamiento del recuerdo y la restriccion. Tiene sentido también, que como el recuerdo y la restricción son iguales a esta ciudad homenajeada, que sea entonces del tipo de una de estas ciudades, y aprovechemos a preguntarles a ellas cuál es el comportamiento que debe tener:

```wollok
object lasVegas{
	var homenajeado = buenosAires
	
	method recuerdo() = homenajeado.recuerdo()
	
	method puedeViajar() = homenajeado.puedeViajar()
}
```

En este caso, siendo la ciudad homenajeada Buenos Aires, el recuerdo será el mismo que Buenos Aires, al igual que la restricción.

#### ⚠ Error común 

Un modelado que se vió también es modelar la ciudad homenajeada como un _string_, y anidar ifs para saber qué comportamiento tiene que usar:

```wollok
object lasVegas{
	var homenajeado = "buenos aires"
	
	method recuerdo(){
	    if(ciudad == "buenos aires"){
	      return "mate con yerba"
	    }else if(ciudad == "paris"){
	      return "llavero"
	    }else if(){
	      ...//etc
	    }
 	 }
	
	method puedeViajar(){
	    if(ciudad == "buenos aires"){
	      return alambiqueVeloz.esRapido()
	    }else if(ciudad == "paris"){
	      return alambiqueVeloz.tieneTanqueLleno() 
	    }else if(){
	      ...//etc
	    }
	}
}
```

Esto nos trae los problemas que habíamos visto antes:

- Repetir la lógica de las restricciones nos complica si a futuro cambian esas lógicas. Si mañana pueden viajar a buenos aires aquellos vehiculos que no sean rapidos, hay que cambiarlo en dos lugares
- No podemos agregar fácilmente más ciudades, ya que habría que completar no uno, si no dos ifs con la condición `ciudad == "nueva ciudad"` además de codear la ciudad en sí.

Si vamos por la solución polimorfica, directamente preguntando a la ciudad homenajeada (a la cual tratamos como objeto) no tenemos estos problemas.

#### Volviendo al ejercicio

Ahora nos queda únicamente los vehiculos, ¡casi estamos! 

En principio tenemos al Alambique Veloz, del cual conocemos:
> Necesita el tanque de combustible lleno para ir a Paris 
> Cada viaje que hace el alambique veloz consume una cierta cantidad de combustible.

Planteamos entonces el objeto y los mensajes que debe entender -> agregamos el atributo combustible, ya que es algo que irá cambiando con el tiempo y de lo cual depende su comportamiento. 

```wollok
object alambiqueVeloz {
	var combustible = 100
	const capacidadTanque = 100 //inventamos un valor máximo del tanque y lo ponemos como constante

	method tieneTanqueLleno() = combustible == capacidadTanque 
	
	method esRapido() = combustible >  capacidadTanque / 2 //inventamos una lógica utilizando también el tanque de combustible
	
	method viajar(){ //hacemos que gaste combustible
		combustible -= 10
	}
}
```
Si no hubiera otro vehículo que Luke manejara, sino que sólo fuera Alambique Veloz, la solución realizada hasta el momento sería suficiente. Pero la consigna nos plantea un nuevo requerimiento, una extensión al problema en la que aparecen otros vehículos con los que el protagonista quiere viajar. 

El haber definido al Alambique Veloz como un objeto diferente nos facilita la tarea, pero de todas maneras es necesario plantear algunos cambios en la solución, en particular ubicar las partes del código donde se mencioanaba explícitamente al Alambique Veloz y reemplazarlas por referencias variables, para que en otro momento de la ejecución del programa puedan hacer referencia a los otros objetos polimórficos en los que tambien pueda viajar, como por ejemplo el Espantomovil y cualquiera que se quiera agregar, y todo siga funcionando adecuadamente.

Es probable que en caso de haber leído de manera completa la consigna ya  hubiérmos previsto la existencia de diversos vehículos y ya en la primera solución anterior hubiéramos implementado lo que vamos a realizar a continuación, pero fuimos avanzando paso a paso y es ante la aparición de este nuevo requerimiento que tiene sentido este cambio.  

En Luke, es conveniente agregar un atributo variable, con el cual siempre sepa qué vehículo tiene disponible para viajar. Inicialmente puede hacer referencia al Alambique Veloz, y luego puede variar, para lo cual agregarmos un método `setter`. El términos de la consigna, el nombre mas evidente para ponerle a esa variable es `vehículo`.

```wollok
object luke{
  var cantidadLugaresVisitados = 0
  var ultimoRecuerdo = ""
  var vehiculo = alambiqueVeloz   // Definimos un nuevo atributo variable y lo inicializamos
  // ...

  method vehiculo(nuevo) {        // Metodo para permitir cambiar el vehículo de Luke
    vehiculo = nuevo
  
  // ...
  method realmenteViajar(){ 
      vehiculo.viajar()          // Ahora el mensaje viajar() se lo enviamos al vehículo que tenga en el momento 
      cantidadLugaresVisitados = cantidadLugaresVisitados + 1
      ultimoRecuerdo = ciudad.recuerdo()
  }  
}
```

También en Paris y Buenos Aires se hacía referencia explícita al Alambique Veloz, asumiendo que era el único vehículo posible. Ahora que puede haber otros es necesario que cada ciudad sepa cuál es el vehículo con que se quiere viajar para decidir si lo deja viajar con él o no. Para ello, cuando Luke le envía el mensaje `puedeViajar()` a la ciudad a la que quiere ir, le va a pasar como argumento el vehículo que tiene en ese momento.  Acompañamos el agregado del parámetro renombrando el mensaje con un término mas expresivo: `puedeViajarCon()`. 

```wollok
object luke{
// ...
method viajarA(ciudad){
    if(ciudad.puedeViajarCon(vehiculo))    // Luke le pasa por parámetro el vehiculo a la ciudad  
       self.realmenteViajar() //es un mensaje de Luke, uso self entonces
  }
//...
}
```

Por su parte, ahora también modificamos la definición de París y Buenos Aires para agregarle el parámetro al método y utilizarlo como objeto receptor del mensaje correpondiente. No debemos olvidar cambiarte también el nombre al método para mantener la consistencia. 


```wollok
object paris{
	method recuerdo() = "llavero"
	method puedeViajarCon(vehiculo) = vehiculo.tieneTanqueLleno() // Con parametro y nuevo nombre
}

object buenosAires{
	var presidente = "Pepita"

	method recuerdo() = "mate" + if(presidente == "Pepita") " con yerba" else ""
	method puedeViajarCon(vehiculo) = vehiculo.esRapido()  // Con parametro y nuevo nombre
}

```
¿Y los otros lugares a los que Luke puede viajar?

Efectivamente, con los cambios realizados, cuando Luke quiera viajar a Bagdad o Las Vegas, le va a enviar un mensaje que estos objetos no entienden, ya que sus métodos quedaron con el nombre anterior y sin parámetros. **¡Rompimos el polimorfismo!**. Pero arreglarlo es sencillo, hagamos el mismo cambio en las otras ciudades. 


Al igual que con las ciudades, ya sabemos gracias al analisis que hicimos antes, que necesitamos que las ciudades entiendan el mensaje `esRapido`, también tienen que tener consecuencias al viajar, por lo que habíamos definido que tenían que entender el mensaje `viajar`; y además que el vehiculo particular `alambiqueVeloz` tiene que entender el mensaje `tieneElTanqueLleno`.

En el caso de Bagdad alcanza con renombrar el método y agregarle el parámetro. Como no es necesario enviarle un mensaje ni utilizarlo para nada, simplemente lo ignoramos. No es un error no usar un parametro que se recibe, es lo que nos permite mantener el polimorfismo.

```wollok
object bagdad{
	var property recuerdo = "bidon con petroleo crudo"
	
	method puedeViajarCon(vehiculo) = true //sigue sin tener restricciones, no hace nada con el objeto recibido por parámetro
}
```

En Las Vegas hacemos el mismo cambio, pero además tenemos que pasarle por parámetro el vehiculo al enviarle el mensaje a la ciudad homenajeada. 

```wollok
object lasVegas{
	var homenajeado = buenosAires
	
	method recuerdo() = homenajeado.recuerdo()
	
	method puedeViajarCon(vehiculo) = homenajeado.puedeViajarCon(vehiculo) // lasVegas recibe un vehiculo por parámetro y a su vez se lo envía a la ciudad homenajeada
}
```

Podemos inventar otro vehiculo, siempre y cuando entienda `viajar` y `esRapido`:

```wollok
object espantoMovil{ //es rapido si tiene menos de 2 ruedas pinchadas
	var ruedasPinchadas = 0
	
	method esRapido() = ruedasPinchadas < 2
	
	method viajar(){} //no tiene consecuencias al viajar
}
```

#### ⚠ Error común

El `espantoMovil` **no tiene por qué entender** el mensaje `tieneTanqueLleno`, ya que en ningún momento se usa ese método de forma polimorfica, solamente se usa en `paris` para preguntarle al `alambiqueVeloz`. En cambio sí necesita poder entender `viajar` (que usa Luke) y `esRapido` que usa Buenos Aires.

#### Volvemos al ejercicio

¡Y listo! Terminamos el TP 😎

