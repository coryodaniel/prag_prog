defmodule PragProg.Ch12.Examples.Bouncer do
  def permit(person) do
    case person do
      %{country: :US, age: age} = person when is_number(age) and age >= 21 -> true
      %{country: :UK, age: age} = person when is_number(age) and age >= 18 -> true
      _ -> false
    end
  end
end
