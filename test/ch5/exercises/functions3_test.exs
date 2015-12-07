defmodule PragProg.Ch5.Functions3 do
  use ExUnit.Case, async: true

  test "FizzBuzz" do
    expected_results = %{
      10 => "Buzz",
      11 => 11,
      12 => "Fizz",
      13 => 13,
      14 => 14,
      15 => "FizzBuzz",
      16 => 16,
      17 => 17
    }

    Enum.each Map.keys(expected_results), fn n ->
      fizzbuzz_result = PragProg.Ch5.Exercises.Functions2.fizzbuzz( rem(n,3), rem(n,5), n )
      assert fizzbuzz_result == expected_results[n]
    end
  end
end
