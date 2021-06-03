## Resumen de fold y recursividad*

Son tres herramientas medianamente equivalentes. 
- **foldl**: En el TP por ejemplo para la fuenteCopada querés `foldl` porque querés foldear de izquierda a derecha para aplicar primero el sueño de la izquierda de la lista. Y fold te resuelve ese problema fácil, no hace falta ir a la recursión.

- **foldr**: Suele ser necesario cuando querés "doblar" , foldear, "empezando" por el  elemento de la derecha de la lista, el último. 

- Si no saben qué parámetro va primero, va segundo, cuál aplico parcialmente, en cualquier cas

- **recursividad** te conviene con los problemas naturalmente recursivos. Hacer un factorial con foldl, si bien se puede, es medio difícil y forzado. Sale mucho más declarativo con recursividad. Lo mismo pasa para el punto 6d

:grey_question: Cómo elijo entonces entre fold y recursión :grey_question: 
Y, si tenés que operar una lista, por ahí con fold es más fácil, pero puede que no.
Y a veces cuando no hay listas es más directo con recursividad, pero puede que no.

La clave es _pensar la **estrategia**_ en cada momento. ¿La puedo pensar en términos de "doblar"/"acumular"/"poner una operación entre dos elementos de la lista"? Si la respuesta es sí, probablemente quiera el fold. 

¿Puedo pensar a una operación como _definida en sí misma_? ¿Si obtengo el resultado de un pasito puedo obtener el siguiente? Si la respuesta es sí, entonces probablemente quiera recursión.

De eso se trata _construir soluciones declarativas_: si mi problema es una "acumulación", una "interpolación de función en la lista", entonces quiero foldl porque justo hace eso. Uso la herramienta que **más se parece a la naturaleza del problema** o bien  más se parece a cómo quiero pensar el problema.

## Ejemplos

1. ¿Con qué harían una función que me diga si una lista `estaOrdenadaAscendentemente`? (recibo lista devuelvo booleano)
2. ¿Con qué harían una función `sort` que ordene una lista según un criterio? (recibo lista y criterio, devuelvo lista)
3. ¿Con qué harían una función `corregirTodos` que muestre cómo queda un docente luego de corregir 89 parciales?

## Conclusión

Ojo, en los parciales suele pasar que _hay una mezcla_ de varias cosas entre las que está el fold. El fold o la recursividad no suelen ser difíciles. Lo que garpa es plantear bien el problema, entendiendo **el tipo de la función principal** (qué se espera, qué se devuelve) , utilizando un enfoque **TOP -DOWN** y **dividiendo en subtareas**.  También se espera que utilicen funciones existentes y construyan sus propias abstracciones, para **hacer código más declarativo** y también para evitar **repetir código**.