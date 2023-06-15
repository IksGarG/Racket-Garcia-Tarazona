## Andres Tarazona Solloa
## Iker Garcia German
## Main file for the prime numbers sum

defmodule Sums do
  # This function checks whether a number is prime
  def is_prime(num) when num < 2, do: false
  def is_prime(num) do
    limit = :math.sqrt(num) |> trunc()
    do_is_prime(num, 2, limit)
  end

  # Helper function for checking primality
  defp do_is_prime(num, checker, limit) when checker > limit, do: true
  defp do_is_prime(num, checker, _) when rem(num, checker) == 0 , do: false
  defp do_is_prime(num, checker, limit), do: do_is_prime(num, checker + 1, limit)

  # This function calculates the sum of primes in a range
  def range_sum({start, finish}) do
    Enum.to_list(start..finish)
    |> Enum.filter(&is_prime/1)
    |> Enum.sum()
  end

  # This function creates ranges based on the number of cores
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

  # Helper function for making ranges
  defp do_make_ranges(start, finish, _, res) when start == finish, do: res
  defp do_make_ranges(start, finish, range, res), do: do_make_ranges(start, finish - range, range, [{finish - range + 1, finish} | res])

  # This function performs parallel summation of primes using multiple cores
  def total_sum(start, finish, cores) do
    make_ranges(start, finish, cores)
    |> Enum.map(&Task.async(fn -> range_sum(&1) end))  # Tasks are distributed among the cores
    |> Enum.map(&Task.await/1)  # Waits for the tasks to finish
    |> Enum.sum()  # Sums the results from each core
  end

  # This function performs sequential prime summation and prints the time taken
  def sequential_prime_sum do
    {time, result} = :timer.tc(fn -> range_sum({2, 5000000}) end)
    IO.puts "Sequential Time: #{div(time, 1000)} milliseconds. Result: #{result}"
    time
  end

  # This function performs parallel prime summation and prints the time taken
  def parallel_prime_sum(cores) do
    {time, result} = :timer.tc(fn -> total_sum(1, 5000000, cores) end)
    IO.puts "Parallel Time with #{cores} cores: #{div(time, 1000)} milliseconds. Result: #{result}"
    time
  end

  # This function calculates the speedup achieved by parallel execution
  def speedup do
    cores = System.schedulers_online()  # Fetches the number of cores available
    t1 = sequential_prime_sum()
    tp = parallel_prime_sum(cores)
    speedup = t1 / tp
    IO.puts "Speedup: #{speedup}"
  end
end
