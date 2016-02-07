defmodule PragProg.Ch10.Exercises.Primes do
  def upto(m) do
    from(2,m)
  end

  def from(n,m) do
    for x <- PragProg.Ch10.Exercises.MyList.span(n,m), is_prime?(x), do: x
  end

  def is_prime?(num) do
    # yeahhhhh, you should stop on the first divisor found for efficiency :P
    divisors = for x <- PragProg.Ch10.Exercises.MyList.span(2, num-1),
      rem(num, x)==0,
      do: num

    divisors == []
  end
end
