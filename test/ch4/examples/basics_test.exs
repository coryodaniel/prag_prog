require IEx
defmodule PragProgTest.Ch3.Basics do
  use ExUnit.Case
  @test_data "test/support/data/santa_monica_trees.csv"

  test "Tuples & File.read" do
    {status, file} = File.read(@test_data)
    assert status == :ok
  end

  test "File.stream! and Regex" do
    # Street name is index 5, lets count trees in the bougie district. MONTANA AVE
    # Going to do this naïvely instead of using the CSV app
    bougie_tree_filter = fn line ->
      Regex.match?(~r{MONTANA\ AVE}, line)
    end

    bougie_trees = File.stream!(@test_data) |> Enum.filter(bougie_tree_filter)
    assert Enum.count(bougie_trees) == 354
  end

  test "Keyword lists pg28"
  test "Maps"
  test "Binaries"
end
