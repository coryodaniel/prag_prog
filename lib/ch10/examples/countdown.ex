defmodule PragProg.Ch10.Examples.Countdown do
  def sleep(seconds) do
    receive do
      after seconds * 1000 -> nil
    end
  end

  def say(text) do
    spawn fn -> :os.cmd('say #{text}') end
  end

  def timer do
    # multiple function bodies
    current_state = fn
      0 -> {:halt, 0}
      count ->
        sleep(1)
        { [inspect(count)], count - 1}

    end

    deallocation  = fn _ -> end # dont need to do anything to dealloc a timer
    Stream.resource(&starting_seconds/0, current_state, deallocation)
  end

  defp starting_seconds do
    {_h, _m, s} = :erlang.time
    60 - s - 1
  end
end
