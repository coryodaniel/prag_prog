defmodule PragProgTest.Ch5.AnonymousFunctions do
  use ExUnit.Case, async: true
  @test_data "test/support/data/santa_monica_trees.csv"

  test "Swappin values" do
    swap = fn {a,b} -> {b,a} end

    assert swap.({6,8}) == {8,6}
  end

  test "Multiple parameter lists" do
    handle_open = fn
      ({:ok, file})  -> "Read data: #{IO.read(file, :line)}..."
      ({_,   error}) -> "Error: #{:file.format_error(error)}"
    end

    successful_read = handle_open.(File.open(@test_data))
    failed_read = handle_open.(File.open("nope-file.nope"))

    assert Regex.match?(~r{Read.*}, successful_read)
    assert Regex.match?(~r{Error:.*}, failed_read)
  end

  test "Higher-order funtions" do
    greeter_factory = fn
      :mean -> (fn (name)-> "What do you want, #{name}?" end)
      :nice -> (fn (name)-> "Good day to you, #{name}!" end)
    end

    mean_greeter = greeter_factory.(:mean)
    nice_greeter = greeter_factory.(:nice)

    assert mean_greeter.("Cory") == "What do you want, Cory?"
    assert nice_greeter.("Cory") == "Good day to you, Cory!"
  end
end
