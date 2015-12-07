defmodule PragProg.Ch5.Functions1 do
  use ExUnit.Case, async: true

  test "list_concat" do
    list_concat = fn (l1,l2) -> l1 ++ l2 end
    assert list_concat.([:a,:b],[:c,:d]) == [:a,:b,:c,:d]
  end

  test "sum" do
    # No variadic functions in elixir... and ints are not being passed as a list.
    sum = fn (a,b,c) -> a + b + c end
    assert sum.(1,2,3) == 6
  end

  test "pair_tuple_to_list" do
    # I solved this two ways before I found Tuple.to_list/1 so I figured why
    # not over engineer this test :D
    tuple_to_list_solutions = [
      &Tuple.to_list/1,
      fn (tuple) -> [ elem(tuple, 0), elem(tuple, 1) ] end,
      fn (tuple) ->
        {first_val, second_val} = tuple
        [ first_val, second_val ]
      end
    ]

    pair_tuple_to_list = fn (tuple) ->
      func = Enum.random(tuple_to_list_solutions)
      func.(tuple)
    end

    assert pair_tuple_to_list.( {1234, 5678} ) == [ 1234, 5678 ]
  end
end
