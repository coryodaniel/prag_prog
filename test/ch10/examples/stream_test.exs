defmodule PragProg.Ch10.StreamTest do
  use ExUnit.Case, async: true

  # Good for:
  # * deferring processing until you need data
  # * dealing w/ large sets w/o generating them all at once

  # test "longest line" do
  #   ## slow
  #   # word = File.read!("/usr/share/dict/words")
  #   #   |> String.split
  #   #   |> Enum.max_by(&String.length/1)
  #   # assert word == "formaldehydesulphoxylate"
  #
  #   ## Streams can be slow for local files, but good for remote unpredictable
  #   ## IO devices
  #   #
  #   # word = File.read!("/usr/share/dict/words")
  #   #   |> IO.stream(:line)
  #   #   |> Enum.max_by(&String.length/1)
  #   # assert word == "formaldehydesulphoxylate"
  #
  #   # word = File.stream!("/usr/share/dict/words")
  #   #   |> Enum.max_by(&String.length/1)
  #   # assert word == "formaldehydesulphoxylate"
  # end

  test "Stream vs Enum death match" do
    stream_map = Stream.map [1,3,5,7], &(&1 + 1)
    enum_map   = Enum.map [1,3,5,7], &(&1 + 1)

    assert enum_map == [2,4,6,8]

    # Streams are wrappers around an enum and a list of functions to apply to
    # each item as needed
    refute stream_map == [2,4,6,8]
    assert stream_map.enum == [1,3,5,7]
    assert length(stream_map.funs) == 1
  end

  test "Stream.cycle" do
    # continually returns the next value, restart at beginning after last item
    html = Stream.cycle(~w{green white})
      |> Stream.zip(1..5)
      |> Enum.map(fn {class, value} ->
        {class, value} #skipping the <td> example...
      end)

    assert html == [{"green", 1}, {"white", 2}, {"green", 3}, {"white", 4}, {"green", 5}]
  end

  test "Stream.repeatedly" do
    # Applies the function each time called
    randos = Stream.repeatedly(&:random.uniform/0) |> Enum.take(3)

    Enum.each(randos,fn(rando) ->
      assert 0 <= rando && rando <= 1
    end)
  end

  test "Stream.iterate" do
    numbers = Stream.iterate(0, &(&1+1)) |> Enum.take(5)
    assert numbers == [0, 1, 2, 3, 4]

    # Stream.iterate(start_val, next_fun) continually applies next_fun to prev_value
    # seeding with start_val
    numbers = Stream.iterate(2, &(&1 * &1)) |> Enum.take(5)
    assert numbers == [2, 4, 16, 256, 65536]

    numbers = Stream.iterate(2, &(&1 * &1)) |> Enum.take(5)
    assert numbers == [2, 4, 16, 256, 65536]
  end

  test "Stream.unfold" do
    # Stream.unfold(initial_state, state_manipulator)
    #   state_manipulator -> fn(state) -> {stream_val, new_state} end
    fib = Stream.unfold({0, 1}, fn({f1, f2}) ->
      #{ val_to_return_for_this_iteration, {tuple_for_next_fun}}
      {f1, {f2, f1+f2}}
    end) |> Enum.take(15)

    # result will be a list of all of the f1s
    assert fib == [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377]

    # Decided to go bananas with this example...
    nonsense = Stream.unfold("ba", fn(phrase) ->
      more_nonsense = cond do
        String.ends_with?(phrase, ["nana"]) -> " ba"
        true -> "na"
      end

      { phrase, phrase <> more_nonsense }
    end) |> Enum.take(4)

    assert nonsense == ["ba", "bana", "banana", "banana ba"]
  end

  #test "Stream.resource" do
    # Built on Stream.unfold w/ 2 changes
    # 1. first arg to unfold is initial value,
    #   but if its a resource, dont open it until it delivers values
    #   So resource takes a function that returns the value
    # 2. takes a third argument that receives the accumulator and does whatever
    #   needs to be done to deallocate the resource

    # All the kewl things below
    # alias PragProg.Ch10.Examples.Countdown
    # counter = Countdown.timer
    # printer = counter |> Stream.each(&IO.puts/1)
    # speaker = printer |> Stream.each(&Countdown.say/1)
    # speaker |> Enum.take(5)
    #
    # seconds = Countdown.timer |> Enum.take(2)
    # assert length(seconds) == 2
  #end
end
