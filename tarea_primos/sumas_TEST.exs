# Test module, not final version

defmodule Sums do

  def is_prime(num) do
    do_is_prime(num, 2)
    |> IO.inspect()
  end

  defp do_is_prime(num, checker) when num == checker, do: true
  defp do_is_prime(num, checker) when rem(num, checker) == 0 , do: false
  defp do_is_prime(num, checker), do: do_is_prime(num, checker + 1)

  def range_sum({start, finish}) do
    Enum.to_list(start..finish)
    |> Enum.filter(&is_prime(&1))
    |> IO.inspect()
    |> Enum.sum()
    |> IO.inspect()
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
    |> IO.inspect()
    |> Enum.map(&Task.await(&1))
    |> Enum.sum()
  end
end
