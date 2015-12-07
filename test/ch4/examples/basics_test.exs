defmodule PragProg.Ch3.Basics do
  use ExUnit.Case, async: true
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

    bougie_tree_count =
      File.stream!(@test_data) |>
      Enum.filter(bougie_tree_filter) |>
      Enum.count

    assert( bougie_tree_count== 354)
  end

  test "Lists" do
    drinks  = ["coffee", "tea", "water", "whiskey"]
    meat    = ["bacon", "antelope", "eggs"]
    veggies = ["tomatoes", "salad"]
    fruit   = ["pineapples", "apples"]

    buffet = drinks ++ meat ++ veggies ++ fruit

    happy = Enum.any?(buffet, fn(x) ->
      x == "bacon" || x == "coffee"
    end)
    assert happy

    also_happy = "pineapple" in buffet or "coffee" in buffet
    assert also_happy
  end

  test "Keyword lists" do
    peoples_ages = [cory: 34, alison: 33]

    # keyword lists convert to tuples
    assert peoples_ages == [{:cory, 34}, {:alison, 33}]
    assert peoples_ages[:cory] == 34

    # Return nil for missing key
    refute peoples_ages[:donald]
  end

  test "Keyword lists allow duplicate keys" do
    peoples_ages = [cory: 34, alison: 33, cory: 35]
    assert peoples_ages == [{:cory, 34}, {:alison, 33}, {:cory, 35}]
  end

  test "Maps" do
    states = %{"OH" => "Ohio", "CA" => "California"}
    colors = %{red: 0xff0000, blue: 0x00ff00, green: 0x0000ff}

    # Return nil for missing key
    refute states["FL"]
    refute colors[:purple]

    assert colors[:red]
    refute colors["red"]

    assert states["OH"]
    refute states[:OH]
  end

  test "Map overwrite duplicate keys" do
    cats = %{"Ronald" => 3, "Scooterboots" => 2, "Ronald" => 5}
    assert cats == %{"Scooterboots" => 2, "Ronald" => 5}
  end

  test "Maps w/ dot notation" do
    people = %{cory: 34}

    assert people.cory == 34
    assert_raise KeyError, fn ->
      people.donald
    end
  end

  test "Binaries, oh geez." do
    # Size sets the number of bits used to represent...
    bin = <<3 :: size(2), 5 :: size(4), 1 :: size(2)>>
    bin2 = <<3,5,1>>

    :binary.bin_to_list(bin) #=> [351]
    :binary.bin_to_list(bin2) #=> [3,5,1]

    assert byte_size(bin) == 1
    assert bit_size(bin) == 8

    # Looks like without using ::size() modifier, the default representation is
    # a byte for a binary...
    assert byte_size(bin2) == 3
    assert bit_size(bin2) == 24
  end
end
