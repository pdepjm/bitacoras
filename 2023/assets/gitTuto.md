# Git + Github

### ¿Qué es Git? ¿Qué es Github?

Para contexto sobre estas herramientas, leer [este apunte](https://docs.google.com/document/d/166ksg4rSAIrYWStR5yHrUQjFp1OY3DvSoLMcA8CYc34/edit#) detallado.

### ¿Cómo realizo un TP entregando por Github?

Para realizar un TP, lo primero que tenemos que hacer es **aceptar la asignación**; esto lo haremos dandole click al link al classroom que nos den el docente. 

Una vez que aceptemos la tarea, vamos a tener un **repositorio** bajo el nombre del TP junto con nuestro usuario, por ejemplo para el TP **Propinas**: `2023-f-propinas-dlopezalvas`.

1. Luego, lo que vamos a hacer es **clonar el repo** de la siguiente forma, asegurandonos que estemos copiando el link **HTTPS**:
    * Copiamos el link del repo

    [foto]
    * Teniendo el link vamos a nuestra carpeta y abrimos una terminal (Git Bash en Windows). Acá vamos a escribir el comando `git clone <link>` completando con el link que copiamos previamente

    [foto2]

    * Si trabajamos con VSCode, para abrir nuestro proyecto podemos usar el comando `code <nombre-proyecto>`. Siguiendo el ejemplo, si estamos parados en `~/Desktop/PdeP`, hacemos `code 2023-f-propinas-dlopezalvas`

2. Teniendo nuestro proyecto, vamos a realizar un punto del TP para luego realizar nuestro primer commit.
3. Una vez terminado nuestro primer punto, vamos a elegir qué archivos queremos que se agreguen al commit. Para esto tenemos dos opciones:
    * Desde el VSCode utilizando la pestaña `Source Control`, vamos a ver que nos aparecen los archivos en donde realizamos modificaciones: `Library.hs` y `Spech.hs`
    [foto3]

    Podemos darle click a alguno y ver los cambios que hicimos resaltados para checkear que esté todo bien.

    [foto4]
    
    * Desde la terminal (Git Bash en Windows) utilizando el comando `git add <nombre-archivo>`. En el caso de que queramos agregar todos los archivos que tienen cambios
