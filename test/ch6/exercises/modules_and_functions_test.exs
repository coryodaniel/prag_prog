defmodule PragProg.Ch6.ModulesAndFunctions do
  use ExUnit.Case, async: true

  # compiling a module can be done by:
  # $ iex path/to/file.exs
  # $iex> c "path/to/file.exs"
  test "Times.triple" do
    assert PragProg.Ch6.Exercises.Times.triple(3) == 9
  end

  test "Times.quadruple" do
    assert PragProg.Ch6.Exercises.Times.quadruple(3) == 12
  end

  test "Calculator.sum" do
    assert PragProg.Ch6.Exercises.Calculator.sum(3) == 6
    assert PragProg.Ch6.Exercises.Calculator.sum(0) == 0
  end

  test "Calculator.gcd" do
    assert PragProg.Ch6.Exercises.Calculator.gcd(13,13) == 13
    assert PragProg.Ch6.Exercises.Calculator.gcd(37,600) == 1
    assert PragProg.Ch6.Exercises.Calculator.gcd(20,100) == 20
    assert PragProg.Ch6.Exercises.Calculator.gcd(15,3) == 3
    assert PragProg.Ch6.Exercises.Calculator.gcd(5,0) == 5
  end

  test "Chop.guess" do
    assert PragProg.Ch6.Exercises.Chop.guess(273, 1..1000) == 273
  end

  test "ModulesAndFunctions-7 convert a float to a string (erlang)" do
    # Found 3 ways to convert a float to characters, erlang doesnt have strings right?
    pi = 3.14159265359
    # ommiting a number before the ".2" will keep whatever integer is present
    # otherwise something like "4.2f" rep precision and scale. 4.2f is ok
    # for something like "3.14" but 4.2f for "23.23" will result in some char list
    # funkiness
    #pi_chars = :lists.flatten(:io_lib.format("~.2f",[pi]))
    #pi_chars = :erlang.float_to_list(pi, [{:decimals, 2}])
    [pi_chars] = :io_lib.format("~.2f", [pi])
    assert pi_chars == '3.14'
  end

  test "ModulesAndFunctions-7 Get value of OS ENV variable" do
    assert System.get_env("EDITOR") == "vim"
  end

  test "ModulesAndFunctions-7 Return an extension of a file name" do
    assert Path.extname("cool.jpg") == ".jpg"
  end

  test "ModulesAndFunctions-7 Return the processes cwd" do
    assert Regex.match?(~r{/prag_prog$},System.cwd)
  end

  test "ModulesAndFunctions-7 execute a system command" do
    assert System.cmd("whoami",[]), "coryodaniel"
  end
end
