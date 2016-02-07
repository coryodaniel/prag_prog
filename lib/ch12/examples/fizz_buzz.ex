defmodule PragProg.Ch12.Examples.FizzBuzz do

  def upto(n) do
    1..n |> Enum.map(&fizzbuzz/1)
  end

  defp fizzbuzz(n) do
    cond do
      rem(n, 3) == 0 and rem(n, 5) == 0 -> "FizzBuzz"
      rem(n, 3) == 0 -> "Fizz"
      rem(n, 5) == 0 -> "Buzz"
      true -> n
    end
  end

  def upto_w_pm(n) do
    1..n |> Enum.map(&fizzbuzz2/1)
  end

  defp fizzbuzz2(n) when rem(n, 3) == 0 and rem(n, 5) == 0, do: "FizzBuzz"
  defp fizzbuzz2(n) when rem(n, 3) == 0, do: "Fizz"
  defp fizzbuzz2(n) when rem(n, 5) == 0, do: "Buzz"
  defp fizzbuzz2(n), do: n
end
