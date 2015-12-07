defmodule PragProgTest.Ch5.Functions5 do
  use ExUnit.Case, async: true

  test "rewrite expressions using &" do
    assert Enum.map [1,2,3,4], &(&1 + 2) == [3,4,5,6]
    #assert Enum.map [1,2,3,4], &(IO.inspect(&1)) == [3,4,5,6]
  end
end
