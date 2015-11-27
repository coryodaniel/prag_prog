defmodule PragProgTest.Ch2.PatternMatching1 do
  use ExUnit.Case

  test "Which of the following will match? (a = [1,2,3])" do
    a = [1,2,3]
    assert a == [1,2,3]
  end

  test "Which of the following will match? (a = 4)" do
    a = 4
    assert a == 4
  end

  test "Which of the following will match? (4 = a)" do
    # Assuming the text wanted to illustrate pattern matching on already
    # assigned value
    a = 4
    assert 4 = a
  end

  test "Which of the following will match? ([a,b] = [1,2,3])" do
    assert_raise MatchError, fn ->
      [a,b] = [1,2,3]
    end
  end

  test "Which of the following will match? (a = [[1,2,3]])" do
    a = [[1,2,3]]
    assert a == [[1,2,3]]
  end

  test "Which of the following will match? ([a] = [[1,2,3]])" do
    [a] = [[1,2,3]]
    assert a == [1,2,3]
  end

  test "Which of the following will match? ([[a]] = [[1,2,3]])" do
    assert_raise MatchError, fn ->
      [[a]] = [[1,2,3]]
    end
  end
end
