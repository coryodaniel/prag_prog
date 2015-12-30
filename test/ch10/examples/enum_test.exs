defmodule PragProg.Ch10.EnumTest do
  use ExUnit.Case, async: true
  require Integer
  test "Enumeratin'" do
    list = Enum.to_list 1..5
    assert list == [1,2,3,4,5]

    list = Enum.concat([1,2,3],[4,5,6])
    assert list == [1,2,3,4,5,6]

    list = Enum.concat([1,2,3],'abc')
    assert list = [1,2,3,97,98,99]

    list = [1,2,3]
    assert Enum.map(list, &(&1 * 2)) == [2,4,6]
    assert Enum.map(list, &String.duplicate("*",&1)) == ["*","**","***"]

    assert Enum.at([1,2,3], 0) == 1
    assert Enum.at([1,2,3], 100, :moo) == :moo

    list = Enum.to_list 1..15
    assert Enum.filter(list, &(&1 < 5)) == [1,2,3,4]
    assert Enum.filter(list, &Integer.is_odd/1) == [1,3,5,7,9,11,13,15]
    assert Enum.reject(list, &Integer.is_odd/1) == [2,4,6,8,10,12,14]

    words = ["cat", "banana", "zoo", "chicken hat"]

    # Sort defaults to alpha for words
    assert Enum.sort(words) == ["banana", "cat", "chicken hat", "zoo"]

    by_length = fn(word1,word2) ->
      String.length(word1) <= String.length(word2)
    end
    assert Enum.sort(words, by_length) == ["cat", "zoo", "banana", "chicken hat"]

    # Sort defaults to alpha for words
    assert Enum.max(words) == "zoo"
    assert Enum.max_by(words, &String.length/1) == "chicken hat"

    list = [1,2,3,4,5]
    assert Enum.take(list,3) == [1,2,3]
    assert Enum.take_every(list,2) == [1,3,5]
    assert Enum.take_while(list, &(&1<4)) == [1,2,3]

    # note, returns a tuple bro!
    assert Enum.split(list,3) == {[1,2,3],[4,5]}

    # Enum.split_while splits the Enumerable WHILE its true, it halts on the first false so...
    assert Enum.split_while(list, &( &1 < 4)) == {[1,2,3],[4,5]}
    assert Enum.split_while(list, fn(int) -> Integer.is_odd(int) end) == {[1], [2,3,4,5]}
    refute Enum.split_while(list, fn(int) -> Integer.is_odd(int) end) == {[1,3,5], [2,4]}

    assert Enum.join(list) == "12345"
    assert Enum.join(list, ", ") == "1, 2, 3, 4, 5"

    list = [1,2,3,4,5]
    refute Enum.all?(list, &Integer.is_odd/1)
    assert Enum.any?(list, &Integer.is_odd/1)

    assert Enum.member?(list,3)
    refute Enum.empty?(list)

    list = [1,2,3]
    assert Enum.zip(list, [:a,:b,:c]) == [{1, :a}, {2, :b}, {3, :c}]

    # zip truncates the longer list to the shorter list
    assert Enum.zip(list, [:a]) == [{1, :a}]
    assert Enum.zip(list, [:a,:b,:c,:d]) == [{1, :a}, {2, :b}, {3, :c}]

    assert Enum.with_index([:a,:b]) == [{:a,0},{:b,1}]

    list = 1..100
    assert Enum.reduce(list, &(&1 + &2)) == 5050

    sum_of_evens = list |> Enum.filter(&Integer.is_even/1) |> Enum.reduce(&(&1 + &2))
    assert sum_of_evens == 2550

    words = ["now","is","the","time"]
    longest_word = Enum.reduce(words, fn word, longest ->
      if String.length(word) > String.length(longest) do
        word
      else
        longest
      end
    end)
    assert longest_word == "time" #it certainly is, amirite?

    measure_words = fn(word,previous_length) ->
      current_length = String.length(word)
      if String.length(word) > previous_length do
        current_length
      else
        previous_length
      end
    end
    assert Enum.reduce(words, 0, measure_words) == 4
  end

  test "shuffling cards" do
    import Enum
    # for each combination of each collection in a "for" list comprehension do...
    deck = for rank <- '23456789TJQKA', suit <- 'CDHS', do: [suit,rank]

    hand = deck |> shuffle |> take(13)
    # nothing to assert here, just being a cool baller $$$
  end
end
