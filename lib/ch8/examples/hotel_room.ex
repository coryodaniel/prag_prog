defmodule PragProg.Ch8.Exercises.HotelRoom do
  def book( %{name: name, guests: guests, room_type: room_type} )
  when room_type == :king and guests <= 2, do: confirm(name)

  def book( %{name: name, guests: guests, room_type: room_type} )
  when room_type == :queen and guests <= 4, do: confirm(name)

  def book( %{name: name, guests: guests, room_type: room_type} )
  when room_type == :twin and guests <= 4, do: confirm(name)

  def book( %{name: name, guests: guests, room_type: room_type} )
  when room_type == :queen and guests == 5, do: "You need a cot!"

  def book( %{name: name, guests: guests, room_type: room_type} )
  when room_type == :twin and guests == 5, do: "You need a cot!"

  def book( %{name: name, guests: guests, room_type: room_type} ), do: "You need more rooms!"

  defp confirm(name) do
    "All booked, #{name}!"
  end
end
