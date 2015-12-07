defmodule PragProgTest.Ch5.Functions4 do
  use ExUnit.Case, async: true

  test "Currying functions" do
    curry = fn (prefix) ->
      fn (name) -> "#{prefix} #{name}" end
    end

    assert curry.("Mr.").("O'Daniel") == "Mr. O'Daniel"
  end
end
