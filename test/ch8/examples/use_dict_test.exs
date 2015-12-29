defmodule PragProg.Ch8.UseDict do
  use ExUnit.Case, async: true
  alias PragProg.Ch8.Exercises.Sum

  # Dict, HashDict dep -> Map
  # Set, HashSet dep -> MapSet

  test "Summing the values of a Keyword List" do
    kw_list = [one: 1, two: 2, three: 3]
    assert Sum.values(kw_list) == 6
  end

  test "Summing the values of a HashDict" do
    map = [one: 1, two: 2, three: 3] |> Enum.into(Map.new)
    assert Sum.values(map) == 6
  end

  test "Summing the values of a Map" do
    map = %{ four: 4, five: 5}
    assert Sum.values(map) == 9
  end

  test "~Dict API (deprecated) -> Map API" do
    kw_list = [name: "Cory", likes: "Whiskey", where: "Los Angeles"]

    map = Enum.into kw_list, Map.new
    map = Map.put(map, :likes, "Steak")
    city = Map.get(map, :where)

    assert map.name == kw_list[:name]
    assert map.likes == "Steak"
    assert city == "Los Angeles"
  end

  test "Dupicate keyword values" do
    kw_list = [name: "Cory", likes: "Whiskey", where: "Los Angeles"]
    kw_list = kw_list ++ [likes: "Steak"]
    likes = Keyword.get_values(kw_list,:likes)

    # Eh, dont like that is asserting a specific order...
    assert likes == ["Whiskey", "Steak"]

    # this feels wrong...
    assert Enum.find(likes, fn(like) -> like == "Whiskey" end)       #=> Whiskey
    assert Enum.find_value(likes, fn(like) -> like == "Whiskey" end) #=> true
    assert Enum.find(likes, fn(like) -> like == "Steak" end)         #=> Steak
    assert Enum.find_value(likes, fn(like) -> like == "Steak" end)   #=> true

    # Yep that was wrong...
    assert Enum.member?(likes, "Whiskey")
    assert Enum.member?(likes, "Steak")
  end

  test "Pattern matching and variable map keys" do
    things_and_colors = %{sky: "blue", sun: "orange", ocean: "blue", grass: "green"}
    %{ocean: ocean_color} = things_and_colors
    assert ocean_color == "blue"

    # Pin variables to match dynamic keys
    thing_to_look_for = :ocean
    %{^thing_to_look_for => found_color} = things_and_colors
    assert found_color == "blue"
  end

  test "Ye old Pattern matching" do
    sky = %{name: "sky", color: "blue"}

    assert %{name: _, color: _} = sky
    assert %{name: _, color: "blue"} = sky

    assert_raise MatchError, fn ->
      %{name: _, color: "orange"} = sky
    end

    assert_raise MatchError, fn ->
      %{name: _, length: _} = sky
    end
  end

  test "Variable map keys" do
    cookie_monster = "Cookie Monster"
    neptune = "Neptune"

    things = %{
      cookie_monster => "blue",
      neptune => "blue",
      :sky => "blue",
      :sun => "orange",
      :ocean => "blue",
      :grass => "green"
    }

    filter = fn{_k,v} -> v == "blue" end
    mapper = fn{k,_v} -> k end
    blue_things = Enum.filter_map(things, filter, mapper)

    assert Enum.member?(blue_things, "Cookie Monster")
    assert Enum.member?(blue_things, "Neptune")
    assert Enum.member?(blue_things, :sky)
    assert Enum.member?(blue_things, :ocean)
  end

  test "Destructured list comprehension" do
    things = [
      %{name: "sky", color: "blue"},
      %{name: "grass", color: "green"},
      %{name: "ocean", color: "blue"},
      %{name: "sun", color: "orange"},
    ]

    for thing = %{color: color} <- things,
      color == "blue",
      do: assert Enum.member?(["sky", "ocean"], thing[:name])
  end
end
