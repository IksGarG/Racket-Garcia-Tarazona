##

defmodule Concur do
  def test_function(id) do
    IO.puts("Hello from #{id}")
  end

  def main() do
    IO.puts("Main thread")
    # Create a new process
    id1 = Task.async(fn -> test_function("One") end)
    id2 = Task.async(fn -> test_function("Two") end)
    id3 = Task.async(fn -> test_function("Three") end)
    # Wait for the processes to finish
    Task.await(id1)
    Task.await(id2)
    Task.await(id3)
    IO.puts("Main thread finished")
  end

  def main2() do
    IO.puts("Main thread")
    # Create a new process
    ["One", "Two", "Three", "Four"]
    |> Enum.map(&Task.async(fn -> test_function(&1) end))
    |> IO.inspect
    |> Enum.map(&Task.await/1)
    |> IO.inspect
    IO.puts("Main thread finished")
  end


end

defmodule Sums do
  def range_sum({start, stop}) do
    Enum.sum(start..stop)
  end
  
  def make_ranges(start, stop, n) do
    [{100,200}, {201,300}, {301,400}, {401, 500}}]
  end

  def total_sum(start, stop, n) do
    IO.puts("Thread started")
    make_ranges(start, stop, n)
    |> Enum.map(&Task.async(fn -> range_sum(&1) end))
    |> IO.inspect
    |> Enum.map(&Task.await/1)
    |> IO.inspect
    IO.puts("Main thread finished")
  end
end
