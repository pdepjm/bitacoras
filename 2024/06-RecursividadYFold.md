
# Clase 06: Recursividad, Fold y Evaluación Diferida.

Fecha: 16/05/2023

### Material que acompaña la clase

* [Video con explicación del TP Individual Artistas Exitosos](https://youtu.be/EvDIMbOHy-w) y el [repo con el código de la solución](https://github.com/pdepjm/2024-f-tpi-2-lspigariol).
* [Código hecho en clase](https://github.com/pdepjm/2024-f-clase-06/blob/main/src/Library.hs).
* Laboratorio: ejercicio de **Pókemon**. [Enunciado](https://docs.google.com/document/d/12p0b6g3LU1o135u1OwACyRe_pa_dYwU0AmJ8Z-ZgXj4/edit), [classroom para crear el repo](https://classroom.github.com/a/DoG797SH) y [posible solución](https://github.com/pdepjm/2024-f-pokemon-dlopezalvas/blob/main/src/Library.hs).
* [Video de Fold](https://www.youtube.com/watch?v=veiQkxz59NE).
* [Video de lazy evaluation](https://www.youtube.com/watch?v=wZ0pBezum58)
* En la sección de [Apuntes](https://www.pdep.com.ar/material/apuntes#h.38a137fb537f40e1_55), Módulos 4 y 5 y apunte de "la familia fold".

### Próximas tareas:

#### 23/05 -  TP2 Grupal 
* Se continúa trabajando sobre el repo del TP1
* [Consigna](https://docs.google.com/document/d/1zS67A3HqG9B_kj-22Rv6kJ3NEjHFJRUG2G-4mzjFmNQ/edit).

#### Antes del 27/05 - Recuperatorio TP2 Individual
* Se hace en el [mismo repo](https://classroom.github.com/a/864bjaJG) que el TP2 Individual.
* Se entrega **impreso** el jueves 23 o el 30.
* El enunciado continúa el mismo trabajo práctico:

**Enunciado**

5) Dada una lista de artistas, se desea conocer el _apellido_ de los artistas _prolíficos_, que son aquellos que tienen más de dos canciones en su haber. Resolverlo haciendo buen uso de aplicación parcial, composición y división en subtareas.

Ejemplo:
```
ghci> apellidosProlificos [fitito, calamardo, paty]
["Paez","Calamardo"]
```

Considerar que un artista tiene siempre un sólo nombre y un sólo apellido, separados por un espacio, e investigar la función `words`.

6) Hacer una versión de la función anterior en una sola línea, sin crear funciones auxiliares y sin utilizar expresiones lambdas.
