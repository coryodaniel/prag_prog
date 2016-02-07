defmodule PragProg.Ch11.Examples.ParseTest do
  use ExUnit.Case, async: true
  alias PragProg.Ch11.Examples.Parse

  test "Parse.number('123')" do
    assert Parse.number('123') == 123
  end

  test "Parse.number('-123')" do
    assert Parse.number('-123') == -123
  end

  test "Parse.number('+123')" do
    assert Parse.number('+123') == 123
  end

  test "Parse.number('+9')" do
    assert Parse.number('+9') == 9
  end

  test "Parse.number('+banana')" do
    assert_raise RuntimeError, fn ->
      Parse.number('+banana')
    end
  end
end
