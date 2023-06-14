# LUA Lxer

## Introducción
El módulo `Lexer` es un sencillo analizador léxico escrito en Elixir. Toma un archivo con código fuente como entrada y genera un archivo HTML donde cada tipo de token (palabras clave, números, operaciones, etc.) en la entrada está resaltado con un color específico.

## Componentes Clave

### lexer/2
Esta función lee el contenido del archivo de entrada y procesa cada línea llamando a la función `readline/1`. Las líneas procesadas se unen en una única cadena, que se inserta en la salida HTML.

### readline/1
Esta función captura el espacio en blanco inicial en una línea de código y llama a la función `process_line/3` para procesar el resto de la línea.

### process_line/3
Esta función toma una línea de código, identifica el tipo del primer token en la línea, y lo envuelve en una etiqueta `<span>` con una clase CSS correspondiente a su tipo. El resto de la línea se procesa de manera recursiva.

## Cómo Probar

Para probar este módulo, necesitas llamar a la función `lexer/2` con los nombres de los archivos de entrada y salida como argumentos. Por ejemplo:

```elixir
Lexer.lexer("dot_file.lua", "dot_file.html")
```

Este comando leerá el archivo `dot_file.lua`, lo procesará, y escribirá la salida HTML en el archivo `dot_file.html`.

## Tokens y Colores Correspondientes

| Token       | Clase CSS  | Color  |
| ----------- | ---------- | ------ |
| Palabra clave | keyword   | azul marino |
| Cadena de texto | highlight | verde  |
| Número     | number     | cafe |
| Paréntesis | parenthesis | negro  |
| Variable   | variable   | morado |
| Operación  | operations | rojo   |
| Comentario | comment    | gris   |
| Función    | function   | azul   |

## Notación Big O

La operación principal de este programa es la función `process_line/3`, que se llama una vez para cada carácter en la entrada. Esta función utiliza expresiones regulares para identificar el tipo de token al inicio de la línea, y la complejidad temporal de estas operaciones es generalmente proporcional a la longitud de la línea. Por lo tanto, la complejidad temporal general del programa es aproximadamente O(n*m), donde n es el número de líneas en el archivo de entrada y m es la longitud media de una línea.

Sin embargo, hay que tener en cuenta que esta es una estimación aproximada y la complejidad temporal real puede variar dependiendo del contenido específico de la entrada. Por ejemplo, las líneas con un mayor número de tokens pueden requerir más tiempo para procesarse. Además, las operaciones de entrada/salida (lectura del archivo de entrada y escritura del archivo de salida) también pueden tener un impacto significativo en el rendimiento.