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
                   .strings {
                     color: gold;
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
    words = String.split(line, "")
    process_line(words, "")
  end
  
  #defp process_line([keyword | rest]) 

  defp process_line([keyword | rest], acc) do
    cond do 
      Regex.scan(~r/\-\-/, keyword) |> Enum.any?() ->
        process_line([], "<span class=\"comment\">#{keyword}#{Enum.join(rest, "")}</span>")
  
    true -> 
    html = cond do
      # To interpret variables
      Regex.scan(~r/\=/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # Operations
      Regex.scan(~r/(\+|\-|\/|\*){1}/, keyword) |> Enum.any?() ->
        "<span class=\"operations\">#{keyword}</span>"

      # Keywords
      Regex.scan(~r/(\bfor\b|\bdo\b|\bif\b|\belse\b|\brepeat\b|\blocal\b|\buntil\b|\bwhile\b|\bin\b|\bthen\b|\bfunction\b|\bend\b|\belseif\b)/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # Strings
      Regex.scan(~r/\"/, keyword) |> Enum.any?() ->
        process_string(String.split(keyword, ""), "", 0)

      # numbers
      Regex.scan(~r/(\b[\d]\b|\b[\d]\.[\d]\b)/, keyword) |> Enum.any?() ->
        "<span class=\"number\">#{keyword}</span>"

      # tailend of funcs
      Regex.scan(~r/\)/, keyword) |> Enum.any?() ->
        process_function(String.split(keyword, ""), "")

      # table
      Regex.scan(~r/(\{|\})/, keyword) |> Enum.any?() ->
        "<span class=\"parenthesis\">#{keyword}</span>"

      true ->
        "<span class=\"variable\">#{keyword}</span>"
    end
    process_line(rest, "#{acc} #{html}")
    end

  end

  defp process_line([], acc), do: acc

  defp process_string(rest, acc, count) when count == 2, do: "<span class=\"strings\">#{acc}</span>"
  defp process_string([head|tail], acc, count) do
    html = cond do
      Regex.scan(~r/\"/, head) |> Enum.any?() ->
        process_string(tail, "#{acc}#{head}", count + 1)

        true ->
          process_string(tail, "#{acc}#{head}", count)
    end
    |> IO.inspect()
  end
  
  defp process_function([], acc), do: acc
  defp process_function([head | tail], acc) do
    IO.puts(head)
    html = cond do
       Regex.scan(~r/\(/, head) |> Enum.any?() ->
        "<span class=\"parenthesis\">#{head}</span>"
        |> process_args(tail, "")

        true ->
        "<span class=\"rest\">#{head}</span>"
        |> process_function(tail, "#{acc}#{html}")
    end
  end

  defp process_args([], acc), do: acc
    
end
