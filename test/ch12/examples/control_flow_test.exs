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
    # cond is for testing multiple conditions, like a series of if else/if
    correct = [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz",
      13, 14, "FizzBuzz", 16, 17, "Fizz", 19, "Buzz"]

    assert FizzBuzz.upto(20) == correct

    # Ditch that cond and go w/ pattern matching...
    assert FizzBuzz.upto_w_pm(20) == correct
  end

  def file_case(path) do
    case File.open(path) do
      {:ok, file} -> "First line: #{IO.read(file, :line)}"
      {:error, reason} -> "Failed to open file: #{reason}"
      _ -> "WTF?"
    end
  end

  test "case" do
    bad_file = file_case("nope.nope")
    assert Regex.match?(~r{^Failed}, bad_file)

    good_file = file_case("test/support/data/santa_monica_trees.csv")
    assert Regex.match?(~r{^First}, good_file)
  end

  alias PragProg.Ch12.Examples.Bouncer
  test "case w/ pattern matching" do
    old_guy = %{country: :US, age: 35, name: "Cory"}
    young_guy = %{country: :US, age: 18, name: "Cory"}

    assert Bouncer.permit(old_guy)

    refute Bouncer.permit(young_guy)
    assert Bouncer.permit(%{ young_guy | country: :UK })
  end

  test "raising exceptions" do
    # exceptions in elixir are only for when literal shit literally hits the literal fan, figuratively speaking
    # A user entering the wrong file name is not an exception, a system not being able to locate
    # a system config file that is expected not to change, is an exception

    boom = fn -> raise "Boom" end

    assert_raise RuntimeError, fn ->
      boom.()
    end
  end

  test "an error tuple when some basic shit goes wrong" do
    some_users_file_they_misspellled = "nope.cvs"
    resp = case File.open(some_users_file_they_misspellled) do
      { :ok, _ } -> "do something with the file"
      { :error, _ } -> "oops they typo'd"
    end

    assert resp == "oops they typo'd"
  end

  # See pg 129 for more on exceptions.
  # Usually one of these forms is OK

  test "a vague MatchError when you get an exception you weren't expecting" do
    # Pattern matching when an error is raised
    assert_raise MatchError, fn ->
      { :ok, file } = File.open("noop.txt")
    end
  end

  test "!bang methods for letting the real exception through" do
    assert_raise File.Error, fn ->
      file = File.open!("noop.txt")
    end
  end


  def ok!(tuple) do
    case tuple do
      {:ok, data} = tuple -> data
      {:error, reason} = tuple -> raise "The problem: #{reason}"
    end
  end

  test "most methods that return :ok or :error have a bang form" do
    # makin a little bang handler for methods that can't bang.
    assert_raise RuntimeError, fn ->
      file = ok! File.open("nope")
    end
  end
end
