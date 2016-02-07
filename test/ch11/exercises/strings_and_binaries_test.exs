defmodule PragProg.Ch11.Examples.StringsAndBinariesTest do
  use ExUnit.Case, async: true

  def only_printable(str) do
    Enum.any?(str, fn(char) ->
      char > ?\s && char < ?~
    end)
  end

  test "StringsAndBinaries-1" do
    assert only_printable('abcd')
    assert only_printable('98765')
    refute only_printable('\r')
  end

  def anagram?(str1, str1), do: false
  def anagram?(str1, str2) do
    str1 = String.downcase(str1) |> String.replace(" ", "") |> String.to_char_list |> Enum.sort
    str2 = String.downcase(str2) |> String.replace(" ", "") |> String.to_char_list |> Enum.sort

    str1 == str2
  end

  test "StringsAndBinaries-2" do
    assert anagram?("table", "bleat") # LIKE A GOAT
    refute anagram?("banana", "banana")
    assert anagram?("parliament", "partialmen")
    assert anagram?("Clint Eastwood", "Old West Action")
  end

  test "StringsAndBinaries-3" do
    catdog = [ 'cat' | 'dog' ]
    # destructures first element as a list, and splats out the remainder for the tail
    assert catdog == ['cat', 100, 111, 103]
  end

  test "Work that mantissa" do
    # IEEE Float
    # sign: 1 bit
    # exponent: 11 bits
    # mantissa: 52 bits
    << sign::size(1), exp::size(11), mantissa::size(52) >> = << 3.14159 :: float >>

    assert (1 + mantissa / :math.pow(2,52)) * :math.pow(2, exp-1023) == 3.14159
  end

  test "bookmark" do
    refute "@PAGE 119: binaries & pattern matching"
  end

end