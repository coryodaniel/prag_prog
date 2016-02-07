defmodule PragProg.Ch12.Examples.ControlFlowTest do
  use ExUnit.Case, async: true
  alias PragProg.Ch12.Examples.FizzBuzz

  def ask_belafonte(str) do
    if Regex.match?(~r{banana}, str) do
      "day-o"
    else
      ~W{¯\(°_o)/¯}
    end
  end

  test "if" do
    assert ask_belafonte("Would you like a banana?") == "day-o"
    assert ask_belafonte("How is Winona doing?") == ~W{¯\(°_o)/¯}
  end

  test "FizzBuzzin like a boss (w/ cond)" do
    correct = [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz",
      13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]

    assert FizzBuzz.upto(20) == correct

    # Ditch that cond and go w/ pattern matching...
    assert FizzBuzz.upto_w_pm(20) == correct
  end

  test "bookmark" do
    refute "pg 127 @ case"
  end
end
