defmodule PragProg.Ch10.ListsAndRecursion do
  use ExUnit.Case, async: true
  alias PragProg.Ch10.Exercises.MyList
  alias PragProg.Ch10.Exercises.Primes
  require Integer

  test "take" do
    assert MyList.take([1, 2, 3], 2) == [1, 2]
    assert MyList.take([1, 2, 3], 10) == [1, 2, 3]
    assert MyList.take([1, 2, 3], 0) == []
    assert MyList.take([1, 2, 3], -1) == [3]
  end

  test "split" do
    assert MyList.split([1, 2, 3], 0) == {[], [1, 2, 3]}
    assert MyList.split([], 2) == {[], []}
    assert MyList.split([1, 2, 3], 2) == {[1, 2], [3]}
    assert MyList.split([1, 2, 3], 10) == {[1, 2, 3], []}
    assert MyList.split([], -5) == {[], []}
    assert MyList.split([1, 2, 3, 4], -2) == {[1, 2], [3, 4]}
    assert MyList.split([1, 2, 3], -5) == {[], [1, 2, 3]}
  end

  test "filter" do
    assert MyList.filter([1, 2, 3, 4], fn(x) -> rem(x, 2) == 0 end) == [2,4]
    assert MyList.filter([1,2,3,4], &Integer.is_even/1) == [2,4]
  end

  test "all?" do
    refute MyList.all?([1,2,3,4], &Integer.is_odd/1)
    assert MyList.all?([1,2,3,4], &(&1 < 100))
  end

  test "flatten" do
    assert MyList.flatten([]) == []
    assert MyList.flatten([1,2]) == [1,2]
    assert MyList.flatten([1,[2,3]]) == [1,2,3]
    assert MyList.flatten([[1], [2,3,[4]],5,[[[6]]]]) == [1,2,3,4,5,6]
  end

  test "each" do
    # How do you test each?!
    # MyList.each('abc', fn(int) ->
    #   IO.puts(int)
    # end)
  end

  test "Prime.is_prime?" do
    assert Primes.is_prime?(5)
    assert Primes.is_prime?(41)
    assert Primes.is_prime?(97)

    refute Primes.is_prime?(4)
    refute Primes.is_prime?(10)
    refute Primes.is_prime?(20)
  end

  test "ListsAndRecursion-7" do
    assert Primes.upto(100) == [2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97]
  end

  test "ListsAndRecursion-8" do
    tax_rates = [ NC: 0.075, TX: 0.08 ]
    orders = [
      [ id: 120, ship_to: :NC, net_amount: 100.00 ],
      [ id: 121, ship_to: :TX, net_amount:  50.00 ],
      [ id: 122, ship_to: :OK, net_amount: 500.00 ],
      [ id: 123, ship_to: :CA, net_amount:  20.00 ],
      [ id: 124, ship_to: :TX, net_amount: 310.00 ],
      [ id: 125, ship_to: :NC, net_amount:  10.00 ],
      [ id: 126, ship_to: :OH, net_amount:  15.00 ],
      [ id: 127, ship_to: :FL, net_amount:  25.00 ]
    ]

    orders_w_tax = for order <- orders,
      tax_rate = tax_rates[ order[:ship_to] ] || 0,
      total_amount = (order[:net_amount] * (1+tax_rate)),
      do: order ++ [total_amount: total_amount]

    amounts = Enum.map(orders_w_tax, &(&1[:total_amount]))
    assert amounts == [107.5, 54.0, 500.0, 20.0, 334.8, 10.75, 15.0, 25.0]
  end
end
