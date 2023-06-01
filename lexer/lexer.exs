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
                    font-family: sans-serif;
                  }
                  .keyword {
                    color: blue;
                  }
                  .rest {
                    color: red;
                  }
                  .highlight {
                    color: green;
                  }
                  .number {
                    color: brown;
                  }
                  .variable {
                    color: purple;
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

  defp process_line([keyword | rest], acc) do
    IO.inspect(acc, label: "Current value")
    html = cond do
      # function
      Regex.scan(~r/\bfunction\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # end
      Regex.scan(~r/\bend\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # comments
      Regex.scan(~r/\-\-/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{acc}</span>"

      # To interpret variables
      Regex.scan(~r/\=/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # Fors
      Regex.scan(~r/\bfor\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # Do
      Regex.scan(~r/\bdo\b/, keyword) |> Enum.any?() ->
        "<span class=\"keyword\">#{keyword}</span>"

      # repeat
      Regex.scan(~r/\brepeat\b/, keyword) |> Enum.any?() ->
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
      Regex.scan(~r/\b\(\b/, keyword) |> Enum.any?() ->
        "<span class=\"number\">#{keyword}</span>"

      true ->
        "<span class=\"variable\">#{keyword}</span>"
    end

    process_line(rest, "#{acc} #{html}")
  end

  defp process_line([], acc), do: acc
end

