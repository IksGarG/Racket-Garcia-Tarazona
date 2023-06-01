Andres Tarazona Solloa
Iker Garcia German

# LEXER de Lua

La funcion del lexer se encuentra en el modulo "Lexer", entonces se llama con Lexer.lexer()

```elixir
Lexer.lexer(in_file, out_file)
```

La variable `in_file` es el archivo que se quiere checar, y el `out_file` es por donde saldría el HTML.

Entonces basado en los ejemplos de nuestro código, se usa de la siguiente forma:

```elixir
Lexer.lexer("lexer.lua", "lexer.html")
Lexer.lexer("test.lua", "text.html")
Lexer.lexer("table.lua", "table.html")
```

## Funcionalidad

El lexer se encarga de leer el archivo y separar los tokens en diferentes categorias, como se muestra en la siguiente tabla:

| Categoría | Descripción |
| --- | --- |
| `keyword` | Palabras reservadas |
| `rest` | Resto de palabras |
| `number` | Números |
| `highlight` | Palabras que se deben resaltar |
| `comment` | Comentarios |
| `parenthesis` | Paréntesis |
| `variable` | Variables |
| `operations` | Operaciones |

## Función principal

La función `process_line/2` recibe una lista de palabras y un acumulador (acc) como entrada. Inspecciona el valor actual del acumulador utilizando `IO.inspect/2`. Luego, verifica si la primera palabra en la lista (`keyword`) cumple ciertas condiciones utilizando expresiones regulares. Si cumple alguna condición, genera un elemento span HTML con una clase específica basada en la condición y lo agrega al acumulador. Si ninguna condición coincide, genera un elemento span HTML con una clase diferente y lo agrega al acumulador. Finalmente, se llama recursivamente a sí misma con las palabras restantes en la lista y el acumulador actualizado.

----------------------------------------------

La complejidad Big O de la función `process_line/2` depende de las operaciones que se realizan dentro de ella:

El bloque `cond` contiene una serie de coincidencias de expresiones regulares utilizando la función `Regex.scan/2`. Cada coincidencia de expresión regular se realiza en la variable `keyword`. La complejidad de la coincidencia de expresiones regulares generalmente depende del tamaño de la entrada y la complejidad del patrón de expresión regular. En este caso, las expresiones regulares parecen ser relativamente simples, por lo que podemos asumir una complejidad temporal lineal para cada operación de coincidencia.

----------------------------------------------


`process_function/2`: Esta función toma una lista de caracteres y un acumulador como entrada. Itera sobre la lista de caracteres y realiza operaciones con expresiones regulares. La complejidad de las operaciones con expresiones regulares dependerá de la longitud de la lista de caracteres y puede considerarse lineal en función de la longitud de la lista.

En resumen, la complejidad general del código puede considerarse lineal en función del tamaño del archivo de entrada y salida, así como de la longitud de las líneas y las palabras en el archivo de entrada.



