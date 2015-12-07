defmodule PragProg.Ch5.AnonymousFunctions do
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

  test "Keep on curryin on" do
    add_2 = fn (n) -> n + 2 end

    apply = fn (fun, value) -> fun.(value) end

    assert add_2.(2) == 4
    assert apply.(add_2, 2) == 4
  end

  test "& more cool stuff" do
    add_one = &(&1 + 1)
    assert add_one.(3) == 4

    # arguments are number ordered
    sum = &(&2 + &1)
    assert sum.(2,2) == 4

    speak = &(IO.puts(&1))

    #assert speak.("hi") == :ok
  end

  test "Optimized &Notation for named functions" do
    # If elixir sees that the args to the function are in the correct order
    # and that the "anonymous" function you were creating is just a reference
    # to a named function, elixir will optimize the call directly to the named
    # function instead of creating an anoymous function that calls it
    rnd = &(Float.round(&1,&2))
    assert rnd == &Float.round/2

    rnd = &(Float.round(&2,&1))
    refute rnd == &Float.round/2
  end

  test "converting tuples into functions" do
    divrem = &{ div(&1,&2), rem(&1,&2) }

    assert divrem.(13,5) == {2,3}
  end

  test "converting lists into functions" do
    double = &[ &1*2, &2*2, &3*2 ]
    assert double.(2,4,6) == [4,8,12]
  end

  test "using & to take a function reference" do
    # Can be used to pass funtions around
    len = &Enum.count/1
    assert len.([1,2,3,4]) == 4
  end
end
