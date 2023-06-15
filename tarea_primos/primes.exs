defmodule Sums do
  def is_prime(num) when num < 2, do: false
  def is_prime(num) do
    limit = :math.sqrt(num) |> trunc()
    do_is_prime(num, 2, limit)
  end

  defp do_is_prime(num, checker, limit) when checker > limit, do: true
  defp do_is_prime(num, checker, _) when rem(num, checker) == 0 , do: false
  defp do_is_prime(num, checker, limit), do: do_is_prime(num, checker + 1, limit)

  def range_sum({start, finish}) do
    Enum.to_list(start..finish)
    |> Enum.filter(&is_prime/1)
    |> Enum.sum()
  end

  def make_ranges(start, finish, cores) do
    range = div(finish - start, cores)
    remainder = rem(finish - start, cores)
    if remainder > 0 do
      finish_temp = finish - remainder - range
      do_make_ranges(start, finish_temp, range, [{finish_temp + 1, finish}])
    else
      do_make_ranges(start, finish, range, [])
    end
  end

  defp do_make_ranges(start, finish, _, res) when start == finish, do: res
  defp do_make_ranges(start, finish, range, res), do: do_make_ranges(start, finish - range, range, [{finish - range + 1, finish} | res])

  def total_sum(start, finish, cores) do
    make_ranges(start, finish, cores)
    |> Enum.map(&Task.async(fn -> range_sum(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.sum()
  end

  def sequential_prime_sum do
    {time, result} = :timer.tc(fn -> range_sum({2, 5000000}) end)
    IO.puts "Sequential Time: #{div(time, 1000000)} seconds. Result: #{result}"
    time
  end

  def parallel_prime_sum(cores) do
    {time, result} = :timer.tc(fn -> total_sum(1, 5000000, cores) end)
    IO.puts "Parallel Time with #{cores} cores: #{div(time, 1000000)} seconds. Result: #{result}"
    time
  end

  def speedup do
    cores = System.schedulers_online()
    t1 = sequential_prime_sum()
    tp = parallel_prime_sum(cores)
    speedup = t1 / tp
    IO.puts "Speedup: #{speedup}"
  end
end
