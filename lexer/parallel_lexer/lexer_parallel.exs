defmodule Lexer do
  def lexer(in_filename, out_filename) do
    data = in_filename
          |> File.stream!()
          |> Enum.map(&readline/1)
          |> Enum.join("<br>")
    # single file version
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

  # This function performs parallel lexing of files using multiple cores
  def parallel_lexer(in_filenames, out_filenames) do
    # Zip the input and output filenames together so each task gets a pair of corresponding filenames
    Enum.zip(in_filenames, out_filenames)
    |> Enum.map(&Task.async(fn -> lexer(elem(&1, 0), elem(&1, 1)) end))  # Tasks are distributed among the cores
    |> Enum.map(&Task.await/1)  # Waits for the tasks to finish
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

  defp token_html([match | _], class, _white_space) do
    {match, class}
  end
end
defmodule PerformanceTest do
  def measure_times_and_speedup() do
    # Measure the time for a single file version
    {time_single, _result_single} = :timer.tc(fn ->
      Lexer.lexer("test.lua", "test.html")
    end)
    IO.puts "Time taken for single file version: #{time_single} microseconds"

    # Measure the time for parallel version
    {time_parallel, _result_parallel} = :timer.tc(fn ->
      Lexer.parallel_lexer(["test.lua", "dot_file.lua", "lexer.lua"], ["test.html", "dot_file.html", "lexer.html"])
    end)
    IO.puts "Time taken for parallel version: #{time_parallel} microseconds"

    # Calculate and print the speedup
    speedup = time_single / time_parallel
    IO.puts "Speedup: #{speedup}"
  end
end
