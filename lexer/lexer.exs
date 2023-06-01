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

      true ->
        "<span class=\"rest\">#{keyword}</span>"
    end

    process_line(rest, "#{acc}#{html}")
  end

  defp process_line([], acc), do: acc
end

