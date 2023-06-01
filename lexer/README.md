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


