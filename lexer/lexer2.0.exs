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
                   .function {
                     color: blue;
                   }
                </style>
              </head>
              <body>
                <pre>#{data}</pre>
              </body>
            </html>
           """

    File.write(out_filename, html)
  end

  def readline(line) do
    white_space = Regex.run(~r/^\s*/, line) |> List.first()
    process_line(line, white_space, "")
  end

  defp process_line("", _white_space, acc), do: acc
  defp process_line(line, white_space, acc) do
    result = cond do
      match = Regex.run(~r/^\-\-.*/, line) ->
        token_html(match, "comment", white_space)

      match = Regex.run(~r/^(function|end|for|do|repeat|local|until|while|in|if|then|else|elseif)\b/, line) ->
        token_html(match, "keyword", white_space)

      match = Regex.run(~r/^(\+|\-|\/|\*|\=)/, line) ->
        token_html(match, "operations", white_space)

      match = Regex.run(~r/^\b\d+[.\d]*\b/, line) ->
        token_html(match, "number", white_space)

      match = Regex.run(~r/^(\(|\)|\,)/, line) ->
        token_html(match, "parenthesis", white_space)

      match = Regex.run(~r/^\b\w+/, line) ->
        if Regex.run(~r/^\b\w+[\.\w+]*\(/, line) do
          token_html(match, "function", white_space)
        else 
          token_html(match, "variable", white_space)
        end

      match = Regex.run(~r/^\"(.*?)\"/, line) ->
        token_html(match, "highlight", white_space)

      match = Regex.run(~r/^\s+/, line) ->
        {match, ""}

      true ->
        {String.slice(line, 0..0), "rest"}
    end

    {token, class} = result
    new_acc = "#{acc}<span class=\"#{class}\">#{token}</span>"
    remaining_code = String.replace(line, token, "", global: false)

    process_line(remaining_code, white_space, new_acc)
  end

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

  defp token_html([match | _], class, _white_space) do
    {match, class}
  end
end
