defmodule PragProgTest.Ch2.PatternMatching3 do
  use ExUnit.Case, async: true

  test "Which of the following will match?" do
    assert_raise MatchError, fn ->
      [a,b,a] = [1,2,3]
    end

    assert_raise MatchError, fn ->
      [a,b,a] = [1,1,2]
    end

    assert a = 1

    assert_raise MatchError, fn ->
      ^a = 2
    end

    assert ^a = 1
    assert ^a = 2 - a
  end
end
