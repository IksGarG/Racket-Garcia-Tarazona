# Andrés Tarazona - A01023332
# Iker García - A01782767

### La función rotate-left toma dos entradas: un número entero n y una lista lst. Devuelve la lista que resulta
### de rotar lst un total de n elementos a la izquierda. Si n es negativo, rota hacia la derecha

defmodule Rotate do
  def rotate_left(n, list) when n > 0 do
    Enum.drop(list, n) ++ Enum.take(list, n)
  end

  def rotate_left(n, list) when n < 0 do
    len = length(list)
    rotate_left(len + n, list)
  end
end

defmodule Ejs do
  # Exercise 4
  def prime_factors(n) do
    do_prime_factors(n, 2, [])
  end

  defp do_prime_factors(n, a, res) when n == a, do: Enum.reverse([a | res])
  defp do_prime_factors(n, a, res) when rem(n, a) == 0, do: do_prime_factors(div(n,a), a, [a | res])
  defp do_prime_factors(n, a, res) when rem(n, a) != 0, do: do_prime_factors(n, a + 1,  res)

  # Exercise 6
  def deep_reverse(lst) do
    do_deep_reverse(lst, [])
  end

  defp do_deep_reverse([], res), do: res
  defp do_deep_reverse([head | tail], res) when is_list(head), do: do_deep_reverse(tail, [deep_reverse(head) | res])
  defp do_deep_reverse([head | tail], res), do: do_deep_reverse(tail, [head | res])


end

# La función gcd toma dos números enteros positivos a y b como entrada, donde a > 0 y b > 0. Devuelve el
# máximo com ́un divisor (GCD por sus siglas en inglés) de a y b. No se debe usar la función gcd o similar
# predefinida.

defmodule GCD do
  def gcd(a, 0), do: a
  def gcd(a, b), do: gcd(b, rem(a, b))
end
