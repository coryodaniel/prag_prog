defmodule PragProgTest.Ch5.Functions2 do
  use ExUnit.Case, async: true

  test "FizzBuzz" do
    assert PragProg.Ch5.Functions2.fizzbuzz(0,0,"whatever") == "FizzBuzz"
    assert PragProg.Ch5.Functions2.fizzbuzz(0,1,"whatever") == "Fizz"
    assert PragProg.Ch5.Functions2.fizzbuzz(1,0,"whatever") == "Buzz"
    assert PragProg.Ch5.Functions2.fizzbuzz(1,1,"whatever") == "whatever"
  end
end
