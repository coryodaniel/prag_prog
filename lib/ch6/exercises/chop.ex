defmodule PragProg.Ch6.Exercises.Chop do
  def guess(target,range = low..high) do
    guess = div(low+high,2)
    #IO.puts "Is it #{guess}?"
    guess(target,guess,range)
  end

  # 273, 500, 1..1000
  defp guess(target,guess,low.._high) when guess > target do
    guess(target,low..guess-1)
  end

  # 273, 250, 1..499
  defp guess(target,guess,_low..high) when guess < target do
    guess(target,guess+1..high)
  end

  defp guess(target,guess,_) when target == guess do
    target
  end

  # Saw this in a forum... pretty cool
  # defp guess(target,target,_) do
  #   target
  # end
end
