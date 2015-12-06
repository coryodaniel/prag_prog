defmodule PragProg.Ch5.Functions2 do
  def fizzbuzz(0,0,_), do: "FizzBuzz"
  def fizzbuzz(0,_,_), do: "Fizz"
  def fizzbuzz(_,0,_), do: "Buzz"
  def fizzbuzz(_,_,arg3), do: arg3
end
