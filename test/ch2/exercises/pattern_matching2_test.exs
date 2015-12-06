defmodule PragProgTest.Ch2.PatternMatching2 do
  use ExUnit.Case, async: true

  test "Which of the following will match? ([a,b,a] = [1,2,3])" do
    assert_raise MatchError, fn ->
      [a,b,a] = [1,2,3]
    end
  end

  test "Which of the following will match? ([a,b,a] = [1,1,2])" do
    assert_raise MatchError, fn ->
      [a,b,a] = [1,1,2]
    end
  end

  test "Which of the following will match? ([a,b,a] = [1,2,1])" do
    [a,b,a] = [1,2,1]
    assert a == 1
    assert b == 2
  end
end
