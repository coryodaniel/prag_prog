defmodule PragProg.Ch5.Functions2 do
  use ExUnit.Case, async: true

  test "FizzBuzz" do
    import PragProg.Ch5.Exercises.Functions2, only: [fizzbuzz: 3]
    assert fizzbuzz(0,0,"whatever") == "FizzBuzz"
    assert fizzbuzz(0,1,"whatever") == "Fizz"
    assert fizzbuzz(1,0,"whatever") == "Buzz"
    assert fizzbuzz(1,1,"whatever") == "whatever"
  end
end
