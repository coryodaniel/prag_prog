defmodule PragProg.Ch8.BookRoom do
  use ExUnit.Case, async: true
  alias PragProg.Ch8.Exercises.HotelRoom

  test "Too many people in a twin room" do
    reservation = %{name: "Cory", guests: 10, room_type: :twin}
    assert HotelRoom.book(reservation) == "You need more rooms!"
  end

  test "Too many people in a queen room" do
    reservation = %{name: "Cory", guests: 10, room_type: :queen}
    assert HotelRoom.book(reservation) == "You need more rooms!"
  end

  test "Too many people in a king room" do
    reservation = %{name: "Cory", guests: 10, room_type: :queen}
    assert HotelRoom.book(reservation) == "You need more rooms!"
  end

  test "Suggest a cot" do
    queen_reservation = %{name: "Cory", guests: 5, room_type: :queen}
    assert HotelRoom.book(queen_reservation) == "You need a cot!"

    twin_reservation = %{name: "Cory", guests: 5, room_type: :twin}
    assert HotelRoom.book(twin_reservation) == "You need a cot!"
  end

  test "Confirm a king room for a guest" do
    reservation = %{name: "Cory", guests: 2, room_type: :king}
    assert HotelRoom.book(reservation) == "All booked, Cory!"
  end

  test "Confirm a queen room for a guest" do
    reservation = %{name: "Cory", guests: 4, room_type: :twin}
    assert HotelRoom.book(reservation) == "All booked, Cory!"
  end

  test "Confirm a queen room for a guest" do
    reservation = %{name: "Cory", guests: 4, room_type: :queen}
    assert HotelRoom.book(reservation) == "All booked, Cory!"
  end

  test "Updating a map" do
    reservation = %{name: "Cory", guests: 3, room_type: :king}
    assert HotelRoom.book(reservation) == "You need more rooms!"

    reservation = %{ reservation | guests: 2 }
    assert HotelRoom.book(reservation) == "All booked, Cory!"
  end
end
