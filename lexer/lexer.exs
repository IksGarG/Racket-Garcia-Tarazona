# With love by:
#   - Andres Tarazona Solloa
#   - Iker Garcia German

defmodule Lexer do
  def lexer(in_filename, out_filename) do
    data = in_filename
          |> File.stream!()
          |> Enum.map(&readline/1)
          |> Enum.join("<br>")

    html = """
            <!DOCTYPE html>
            <html>
              <head>
                <title>Lexer Output</title>
                <style>
                   body {
                     background: lightgray;
                     font-family: sans-serif;
                     font-size: 1.5em;
                   }
                   .keyword {
                     color: navy;
                   }
                   .rest {
                     color: peru;
                   }
                   .highlight {
                     color: green;
                   }
                   .number {
                     color: brown;
                   }
                   .parenthesis {
                     color: black;
                   }
                   .variable {
                     color: purple;
                   }
                   .operations {
                     color: red;
                   }
                   .comment {
                     color: grey;
                   }
                </style>
              </head>
              <body>
                #{data}
              </body>
            </html>
           """

    File.write(out_filename, html)
  end

  def readline(line) do
    words = String.split(line, " ")
    process_line(words, "")
  end
  
  #defp process_line([keyword | rest]) 

  defp process_line([keyword | rest], acc) do
    if Regex.scan(~r/\-\-/, keyword) |> Enum.any?() do
      process_line([], "<span class=\"comment\">#{keyword}#{Enum.join(rest, "")}</span>")

  else
    html = cond do
      # function
      Regex.scan(~r/\bfunction\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # end
      Regex.scan(~r/\bend\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # To interpret variables
      Regex.scan(~r/\=/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # Operations
      Regex.scan(~r/(\+|\-|\/|\*){1}/, keyword) |> Enum.any?() ->
        "<span class=\"operations\">#{keyword}</span>"

      # Fors
      Regex.scan(~r/\bfor\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # Do
      Regex.scan(~r/\bdo\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # repeat
      Regex.scan(~r/\brepeat\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # local
      Regex.scan(~r/\blocal\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # until
      Regex.scan(~r/\buntil\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # while
      Regex.scan(~r/\bwhile\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # in
      Regex.scan(~r/\bin\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # numbers
      Regex.scan(~r/\b[\d]\b/, keyword) |> Enum.any?() ->
        "<span class=\"number\">#{keyword}</span>"

      # parenthesis
      Regex.scan(~r/[\s\S]*\(.*\)/, keyword) |> Enum.any?() ->
        process_function(String.split(keyword, ""), "")

      # table
      Regex.scan(~r/.*\{(.|\,)*\}/, keyword) |> Enum.any?() ->
        "<span class=\"parenthesis\">#{keyword}</span>"

      # if
      Regex.scan(~r/\bif\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # then
      Regex.scan(~r/\bthen\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # else
      Regex.scan(~r/\belse\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      true ->
        "<span class=\"variable\">#{keyword}</span>"
    end
    process_line(rest, "#{acc} #{html}")
    end

  end

  defp process_line([], acc), do: acc

  defp process_function([], acc), do: acc
  defp process_function([head | tail], acc) do
    html = cond do
       Regex.scan(~r/(\(|\))/, head) |> Enum.any?() ->
        "<span class=\"parenthesis\">#{head}</span>"

        true ->
        "<span class=\"rest\">#{head}</span>"
    end
    process_function(tail, "#{acc}#{html}")
  end
end
