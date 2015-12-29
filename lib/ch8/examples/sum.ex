defmodule PragProg.Ch8.Exercises.Sum do
  def values(dict) do
    dict |> Dict.values |> Enum.sum
  end
end
