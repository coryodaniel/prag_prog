defmodule PragProg.Ch7.Exercises.MyList do
  def mapsum(list,fun), do: mapsum(list,fun,0)
  defp mapsum([],_fun,acc), do: acc
  defp mapsum([head|tail],fun,acc) do
    mapsum(tail, fun, acc + fun.(head))
  end

  @doc """
  Avoided Kernel.max to exercise using Guards
  """
  def max([head|tail]), do: _max(tail,head)
  defp _max([],greatest), do: greatest
  defp _max([head|tail],greatest) when head >= greatest,  do: _max(tail,head)
  defp _max([head|tail],greatest) when head < greatest,   do: _max(tail,greatest)

  @caeser_start ?a
  @caeser_end ?z
  @caeser_width @caeser_end - @caeser_start + 1
  def caeser([],_rot), do: []
  def caeser([head|tail],rot)
    when head+rot <= @caeser_end,
    do: [ head+rot | caeser(tail,rot) ]
  def caeser([head|tail],rot)
    when head+rot > @caeser_end,
    do: [ head+rot-@caeser_width | caeser(tail,rot) ]
end
