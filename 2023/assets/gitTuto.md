# Git + Github

### ¿Qué es Git? ¿Qué es Github?

Para contexto sobre estas herramientas, leer [este apunte](https://docs.google.com/document/d/166ksg4rSAIrYWStR5yHrUQjFp1OY3DvSoLMcA8CYc34/edit#) detallado.

### ¿Cómo realizo un TP entregando por Github?

Para realizar un TP, lo primero que tenemos que hacer es **aceptar la asignación**; esto lo haremos dandole click al link al classroom que nos den el docente. 

Una vez que aceptemos la tarea, vamos a tener un **repositorio** bajo el nombre del TP junto con nuestro usuario, por ejemplo para el TP **Propinas**: `2023-f-propinas-dlopezalvas`.

1. Luego, lo que vamos a hacer es **clonar el repo** de la siguiente forma, asegurandonos que estemos copiando el link **HTTPS**:
    * Copiamos el link del repo

![clone](https://user-images.githubusercontent.com/48812037/235389402-4d827867-8410-4b14-867d-a17a76d0bf55.png)

**Otro protocolo para Git**
Si tenes problemas con HTTPS o preferis no usar el token podes probar usar SSH. Aca podes leer [este apunte](https://docs.google.com/document/d/1IX53nPHcQnq5r8ahnEULP73c-CjLETZfGLhnkI8jGUQ/edit#) detallando sobre como configurar ssh.

   * Teniendo el link vamos a nuestra carpeta y abrimos una terminal (Git Bash en Windows). Acá vamos a escribir el comando `git clone <link>` completando con el link que copiamos previamente
![clone-2](https://user-images.githubusercontent.com/48812037/235389438-681025c3-64d7-4017-89c5-32555fdb3ead.png)


   * Si trabajamos con VSCode, para abrir nuestro proyecto podemos usar el comando `code <nombre-proyecto>`. Siguiendo el ejemplo, si estamos parados en `~/Desktop/PdeP`, hacemos `code 2023-f-propinas-dlopezalvas`

2. Teniendo nuestro proyecto, vamos a realizar un punto del TP para luego realizar nuestro primer commit.
3. Una vez terminado nuestro primer punto, vamos a elegir qué archivos queremos que se agreguen al commit. Para esto tenemos dos opciones:
    * Desde el VSCode utilizando la pestaña `Source Control`, vamos a ver que nos aparecen los archivos en donde realizamos modificaciones: `Library.hs` y `Spech.hs`
 
![vs-add](https://user-images.githubusercontent.com/48812037/235389482-2e05c767-51d1-43f1-804b-0e8a9d1f27f7.png)

Podemos darle click a alguno y ver los cambios que hicimos resaltados para checkear que esté todo bien.

![archivos-modificados](https://user-images.githubusercontent.com/48812037/235389554-a4a9afb4-3f52-4e74-a6c8-2aba8a57b51b.png)

Luego apretamos el botón `+` de cada archivo, para así agregarlos para el commit, podemos ver que quedan dentro de la pestaña **Staged changes**

![archivos-modificados](https://user-images.githubusercontent.com/48812037/235389647-458dc15a-e1c3-45e2-b6a4-f8227f074321.png)

   * Desde la terminal (Git Bash en Windows), podemos primero fijarnos los cambios con el comando `git status`:
  
![archivos-modificados](https://user-images.githubusercontent.com/48812037/235390502-eff35b60-80fc-4460-b37a-dc31cc3ad4b9.png)

Vemos que nos aparecen los archivos en los que hicimos cambios en rojo. Luego vamos a agregar los archivos que queramos utilizando el comando `git add <nombre-archivo>`. En el caso de que queramos agregar solo un archivo, vamos a usar `git add <nombre-archivo>`; por ejemplo `git add git add src/Library.hs`. En el caso que queramos subir todos los archivos que tienen cambios podemos usar `git add .`. Podemos ver que luego de esto, los archivos al tirar `git status` están en verde (listos para el commit):

![archivos-modificados](https://user-images.githubusercontent.com/48812037/235390830-c534b90e-da3a-419b-9912-68d0b79c0b91.png)

4. Si es la primera vez que vamos a realizar un commit en la computadora en la que estamos, es necesario que le digamos a Git quién somos. Esto lo hacemos en la terminal (Git bash en Windows), con los comandos: `git config --global user.email "mi@email.com"` y `git config --global user.name "Mi nombre"`:

![archivos-modificados](https://user-images.githubusercontent.com/48812037/235391579-b16fb070-1b03-443b-8049-3da0c7751d7e.png)

5. Una vez que tengamos los archivos preparados para el commit y Git sepa quién somos, realizamos el commit. Esto de nuevo podemos hacerlo de dos formas:

   * Desde el VSCode en la misma pestaña donde agregamos los archivos para el commit, escribimos nuestro mensaje en el cuadro (recuerden que tiene que ser expresivo de lo que estamos commiteando) y le damos click al botón `Commit`:

![archivos-modificados](https://user-images.githubusercontent.com/48812037/235391667-8dffd151-1c94-4b3c-92a4-bb088f038400.png)

   * Desde la consola usamos el comando `git commit -m "<nombre de nuestro commit>"`:

![archivos-modificados](https://user-images.githubusercontent.com/48812037/235392254-1a51428b-bea3-4d0d-8d42-d13859aa3d87.png)

6. Luego de haber commiteado **localmente**, vamos a sincronizarlo con el repo que tenemos en Github. Esto significa que tenemos que hacer un `push`.

   * Desde el VSCode nos alcanza con apretar el botón `Sync Changes`, que podemos ver que nos indica la cantidad de commits que aún no pusheamos (1 en este caso)
 
![archivos-modificados](https://user-images.githubusercontent.com/48812037/235391879-3a3d0c72-80ca-4704-a926-00865a1b9cf9.png)

   * Desde la consola vamos a usar el comando `git push`:

![archivos-modificados](https://user-images.githubusercontent.com/48812037/235392465-3555bfd9-20af-4515-b4dc-f25ffd413ec7.png)

   * En ambos casos, si es la primera vez que pusheamos se nos va a abrir una pestaña pidiendo que iniciemos sesión con mediante el browser, o mediante un token. Si deciden hacerlo mediante el token, pueden crearlo [desde esta página](https://github.com/settings/tokens). Es importante copiarlo y guardarlo en algun lugar, por si en algún momento necesitan usarlo de nuevo.

7. ¡Ya subimos nuestro primer punto! Para el resto del TP realizamos los mismos pasos (2 a 6) cada vez que creamos necesario realizar un commit.

### Resumen de comandos:

* `git clone <link>`: nos clona el repositorio a nuestra computadora con el link que le indiquemos.
* `code <nombre-proyecto>`: nos abre el visual en el proyecto (carpeta) que le indiquemos. 
* `git status`: nos muestra el _estado_ actual en el que estamos, si tenemos archivos preparados para el commit, si tenemos cambios, etc. Este comando está bueno tirarlo antes de hacer cosas como el commit o push para asegurarnos que está todo como queremos que esté.
* `git add <nombre-archivo>`: nos prepara archivos para el commit, según los que le indiquemos. Si queremos agregar todos usamos `git add .`.
* `git commit -m "nombre de commit"`: nos commitea localmente los archivos que preparamos.
* `git push`: sincroniza los cambios con el repositorio que se encuentra en Github.
