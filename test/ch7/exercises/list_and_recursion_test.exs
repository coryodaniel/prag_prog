defmodule PragProg.Ch7.ListsAndRecursion do
  use ExUnit.Case, async: true


  test "MyList.mapsum" do
    alias PragProg.Ch7.Exercises.MyList
    assert MyList.mapsum([1,2,3], &(&1 * &1)) == 14
  end

  test "MyList.max" do
    alias PragProg.Ch7.Exercises.MyList
    assert MyList.max([1,2,3,2,10,5,7,5,3,1]) == 10
    assert MyList.max([3]) == 3
    assert MyList.max([9,8,9,7]) == 9
    assert MyList.max([9,8,7]) == 9
    assert MyList.max([7,8,9]) == 9
  end

  test "MyList.caeser" do
    alias PragProg.Ch7.Exercises.MyList
    assert MyList.caeser('ryvkve', 13) == 'elixir'
    assert MyList.caeser('elixir', 0)  == 'elixir'
    assert MyList.caeser('vkkgz',5)    == 'apple'
  end

  test "MyList.span" do
    alias PragProg.Ch7.Exercises.MyList
    assert MyList.span(3,3) == [3]
    assert MyList.span(1,5) == [1,2,3,4,5]
    assert MyList.span(5,1) == []
    assert MyList.span(-5,1) == [-5,-4,-3,-2,-1,0,1]
  end
end
