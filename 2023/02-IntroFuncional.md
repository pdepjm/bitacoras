# Clase 02: Intro a Funcional

Fecha: 13/04/2023

![tiposHaskell](https://user-images.githubusercontent.com/48812037/231883846-d8926ab7-df67-4bdf-8c1b-ce175a8785d8.png)

### Material que acompaña la clase de hoy

* [Apunte](https://docs.google.com/document/d/1W5BcOmIJMCylqAjqPw1RzPlujycbvNJueh8-Uyc2fMY/) Introducción a Funcional.
* [Video](https://www.youtube.com/watch?v=WV1fPlFAw8M&ab_channel=Mumuki) 4' sobre **paréntesis** y [video](https://www.youtube.com/watch?v=ymCuneefgKU&ab_channel=Mumuki) de 3' sobre **precedencia** en Haskell.
* [Video](https://www.youtube.com/watch?v=qv5RuZl5iCo&ab_channel=Fundaci%C3%B3nUqbar) 5' con ejemplo cortito sobre **Guardas**.
* [Apunte](https://wiki.uqbar.org/wiki/articles/expresividad.html) sobre **expresividad**.
* Para quienes quieran saber sobre `stack` y lo que es un **Gestor de proyectos**, acá hay un [videito](https://www.youtube.com/watch?v=FCwwOM_7jZo&ab_channel=Fundaci%C3%B3nUqbar) de 12'.
* Hoy en el labo hicimos la ejercitación de **Pinos**, acá está la [Tarea del classroom (les crea el repo)](https://classroom.github.com/a/IOppVobu). Recomendamos que intenten terminarlo como práctica y nos consulten las dudas que surjan.

### Tarea obligatoria para la clase que viene

#### **TP1**:
**Fecha de entrega: 20/04**

Entregar en papel, de manera individual, al comienzo de la clase. (No hace falta carpeta, folio, caratula ni elementos extras, puede estar incluso escrito a mano si no tienen forma de imprimir, pero no olviden poner su nombre)

Una empresa abre una cierta cantidad de sucursales y necesita contratar nuevos empleados. La cantidad de empleados para cada sucursal es la misma, y se calcula según el nombre de la empresa, de la siguiente manera:
* Si la empresa es `"Acme"`, son 10 empleados.
* Si el **nombre** de la empresa termina con una letra menor que la con que empieza, son tantos empleados como letras _intermedias_ (o sea, el nombre sin considerar la primera y la última letra). 
    * Por ejemplo `"star"`, contrata 2 empleados por sucursal.
* Si el nombre es **capicúa** y tiene cantidad **par** de letras, los empleados son el doble de la cantidad de letras _intermedias_. 
    * Por ejemplo, `"NOXXON"`, son 8.
* Si la cantidad de letras del nombre es **divisible por 3 o por 7**, la cantidad de empleados es la cantidad de copas del mundo ganadas por Argentina.
* En cualquier otro caso, no se contratan empleados para cada sucursal.

El objetivo final es obtener **la cantidad total de empleados** que va a contratar una empresa 

Presentar el código de la solución y acompañar con un par de ejemplos de consulta y respuesta.
