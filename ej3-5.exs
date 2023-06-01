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

defmodule GCD do
  def gcd(a, 0), do: a
  def gcd(a, b), do: gcd(b, rem(a, b))
end
