Andres Tarazona Solloa
Iker Garcia German

# LEXER de Lua

La función del lexer se encuentra en el módulo "Lexer" y se llama con `Lexer.lexer()`.

```elixir
Lexer.lexer(in_file, out_file)
```

La variable `in_file` es el archivo que se quiere analizar, y `out_file` es el archivo donde se generará el HTML.

Entonces, basado en los ejemplos de nuestro código, se utiliza de la siguiente forma:

```elixir
Lexer.lexer("lexer.lua", "lexer.html")
Lexer.lexer("test.lua", "test.html")
Lexer.lexer("table.lua", "table.html")
```

## Funcionalidad

El lexer se encarga de leer el archivo y separar los tokens en diferentes categorías, como se muestra en la siguiente tabla:

| Categoría    | Descripción                                      |
| ------------ | ------------------------------------------------ |
| `keyword`    | Palabras reservadas                              |
| `rest`       | Resto de palabras                                |
| `number`     | Números                                          |
| `highlight`  | Palabras que se deben resaltar                    |
| `comment`    | Comentarios                                      |
| `parenthesis`| Paréntesis                                       |
| `variable`   | Variables                                        |
| `operations` | Operaciones                                      |

## Función principal

La función `process_line/3` recibe una lista de palabras y un acumulador (`acc`) como entrada. Inspecciona el valor actual del acumulador utilizando `IO.inspect/2`. Luego, verifica si la primera palabra en la lista (`keyword`) cumple ciertas condiciones utilizando expresiones regulares. Si cumple alguna condición, genera un elemento span HTML con una clase específica basada en la condición y lo agrega al acumulador. Si ninguna condición coincide, genera un elemento span HTML con una clase diferente y lo agrega al acumulador. Finalmente, se llama recursivamente a sí misma con las palabras restantes en la lista y el acumulador actualizado.

### Cambios importantes

- Se agregó una nueva variable llamada `white_space` en la función `readline/1` para capturar el espacio en blanco al comienzo de cada línea.

- En la función `process_line/3`, se manejaron dos nuevos casos en el condicional para considerar líneas que consisten únicamente en espacios en blanco y líneas que comienzan con un token individual.

- Se modificó la función `token_html/3` para que siempre devuelva una tupla con el token y la clase correspondiente.

- Se envuelve el contenido de cada línea en un elemento `<pre>` en el código HTML generado para preservar la indentación original del código.

### Complejidad

La complejidad general del código puede considerarse lineal en función del tamaño del archivo de entrada y salida, así como de la longitud de las líneas y las palabras en el archivo de entrada. La coincidencia de expresiones regulares y las operaciones en cada línea se realizan de forma eficiente y no se espera que sean un factor limitante en el rendimiento.



