Hay muchas formas de resolver el mismo problema. ¿Con cuál te quedás?
Con la que mejor se adapta a **qué** querés y no a **cómo** se hace.

Otra forma de verlo: me quedo con la que tiene **menos detalles algorítmicos**. 

#### Ejercicio A:

¿Cuál es la más declarativa, cuál la menos y por qué?
```hs
primeroQueCumple1 criterio (x:xs) 
       | criterio x = x
       | otherwise = primeroQueCumple1 xs
```

```hs
primeroQueCumple2 criterio = head . filter criterio
```

#### Ejercicio B:

¿Cuál es la más declarativa, cuál la menos y por qué?
```hs
estaOrdenadaAscendentemente1 = all esMenorAlSegundo . construirPares
construirPares lista = zip lista (drop 1 lista)
esMenorAlSegundo (primero,segundo) = primero <= segundo
```

```hs
estaOrdenadaAscendentemente2 (primero:segundo:siguientes) = primero <= segundo && estaOrdenadaAscendentemente2 (segundo:siguientes)
estaOrdenadaAscendentemente2 [_] = True
estaOrdenadaAscendentemente2 [] = True
```

```hs
estaOrdenadaAscendentemente3 = fst ( foldl continuaSiendoMenor (True, head lista) lista )
continuaSiendoMenor (continua,anterior) elemento = (continua && anterior <= elemento, elemento)
```

