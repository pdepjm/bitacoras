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

Ya tenemos los métodos que necesitabamos para lo que nos pedía el enunciado :D 
