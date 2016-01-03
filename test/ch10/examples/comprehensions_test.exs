defmodule PragProg.Ch10.Comprehensions do
  use ExUnit.Case, async: true
  require Integer

  test "Multiple generators" do
    result = for x <- [1,2,3,4], y <- [10,100,1000,10_000], do: x * y
    assert result == [
      10, 100, 1000, 10000,
      20, 200, 2000, 20000,
      30, 300, 3000, 30000,
      40, 400, 4000, 40000
    ]
  end

  test "Filters" do
    result = for x <- [1,2,3,4],
                 y <- [10,100,1000,10_000],
                 Integer.is_odd(x), y < 1000, do: x * y
    assert result == [10, 100, 30, 300]
  end

  test "Using into" do
    result = for x <- 1..10, y <- [10,100], Integer.is_even(x),
      into: ["bananas"],
      do: x * y

    assert result == ["bananas", 20, 200, 40, 400, 60, 600, 80, 800, 100, 1000]
  end

  test "Filters on filters on filters" do
    first8 = 1..8
    # all combinations of 1..8 & 1..8
    result = for x <- first8, y <- first8, x >= y, rem(x*y, 10) == 0, do: {x, y}
    assert result == [{5, 2}, {5, 4}, {6, 5}, {8, 5}]
  end

  test "Using comprehension variables" do
    min_maxes = [{1,4}, {2,3}, {10,15}]
    result = for {min,max} <- min_maxes, n <- min..max, do: n
    assert result == [1,2,3,4,2,3,10,11,12,13,14,15]
  end

  test "Destructuring" do
    reports = [ dallas: :hot, la: :smoggy, dc: :muggy, cincinnati: :cold]
    report_by_weather = for {city, weather} <- reports, do: {weather, city}

    assert report_by_weather[:cold] == :cincinnati
  end

  test "On bits, binaries and strings" do
    result = for << ch <- "hello" >>, do: ch # returning character codes
    assert result == 'hello'

    result = for << ch <- "hello" >>, do: <<ch>> #converting back into a string
    assert result == ~w{h e l l o}

    chars = 'hello'
    result = for ch <- chars, do: <<ch>>
    assert result == ~w{h e l l o}
  end

  you are at page 103
end
