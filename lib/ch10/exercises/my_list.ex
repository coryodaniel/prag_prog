defmodule PragProg.Ch10.Exercises.MyList do
  def flatten(list),      do: _flatten(list, [])
  defp _flatten([], acc), do: acc

  # if you flatten the tail portion first,
  # we dont have to do an Enum.reverse
  defp _flatten([head|tail], acc) when is_list(head) do
    _flatten(head, _flatten(tail,acc))
  end

  defp _flatten([head|tail], acc) do
    [head | _flatten(tail, acc)]
  end

  def take(list, 0), do: []
  def take(list, count) when count > 0 do
    {keep, _discard} = split(list, count)
    keep
  end

  def take(list, count) when count < 0 do
    {_discard, keep} = split(list, count)
    keep
  end

  def split(list, count), do: _split(list, count, [])
  defp _split(list, 0, acc), do: {acc, list}
  defp _split([], _count, acc), do: {acc,[]}

  defp _split([head|tail], count, acc) when count > 0 do
    _split(tail, count-1, acc++[head])
  end

  defp _split(list, count, acc) when count < 0 do
    _rsplit(list, count, acc)
  end

  defp _rsplit([], _count, acc), do: {[], acc}
  defp _rsplit(list, 0, acc), do: {list, acc}
  defp _rsplit(list, count, acc) do
    # This sucks?
    [last|rest] = Enum.reverse(list)
    rest = Enum.reverse(rest)
    _rsplit(rest, count+1, [last|acc])
  end

  def filter(list, f, acc \\ [])
  def filter([], _f, acc), do: acc
  def filter([head | tail], f, acc), do: _filter(f.(head), head, tail, f, acc)

  # Wanted to do it without and if statement
  defp _filter(true, prev, list, f, acc), do: filter(list, f, acc++[prev])
  defp _filter(false, _prev, list, f, acc), do: filter(list, f, acc)

  def each([], _), do: :ok
  def each([head|tail], fun) do
    fun.(head)
    each(tail,fun)
  end

  def all?([], _), do: true
  def all?([head|tail], fun) do
    _all?(tail, fun, fun.(head))
  end
  # Wanted to do it without a conditional
  defp _all?(_, _, false), do: false
  defp _all?(list, fun, true) do
    all?(list, fun)
  end
end
