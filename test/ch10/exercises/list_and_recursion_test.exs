defmodule PragProg.Ch10.ListsAndRecursion do
  use ExUnit.Case, async: true
  alias PragProg.Ch10.Exercises.MyList
  require Integer

  @list [1,2,3,4]

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
    assert MyList.filter(@list, &Integer.is_even/1) == [2,4]
  end

  test "all?" do
    refute MyList.all?(@list, &Integer.is_odd/1)
    assert MyList.all?(@list, &(&1 < 100))
  end

  test "each" do
    # MyList.each('abc', fn(int) ->
    #   IO.puts(int)
    # end)
  end
end
