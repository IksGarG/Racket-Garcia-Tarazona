# Ejercicios 4 y 6 Tarea 2.2 en Elixir

# Andrés Tarazona - A01023332
# Iker García - A01782767


defmodule Ejs do
  def prime_factors(n) do
    do_prime_factors(n, 2, [])
  end

  defp do_prime_factors(n, a, res) when n == a, do: Enum.reverse([a | res])
  defp do_prime_factors(n, a, res) when rem(n, a) == 0, do: do_prime_factors(div(n,a), a, [a | res])
  defp do_prime_factors(n, a, res) when rem(n, a) != 0, do: do_prime_factors(n, a + 1,  res)


  def deep_reverse(lst) do
    do_deep_reverse(lst, [])
  end

  defp do_deep_reverse([], res), do: res
  defp do_deep_reverse([head | tail], res) when is_list(head), do: do_deep_reverse(tail, [deep_reverse(head) | res])
  defp do_deep_reverse([head | tail], res), do: do_deep_reverse(tail, [head | res])


end
