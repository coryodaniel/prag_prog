defmodule PragProg.Ch8.StructTest do
  use ExUnit.Case, async: true
  alias PragProg.Ch8.Exercises.Subscriber
  alias PragProg.Ch8.Exercises.BugReport
  alias PragProg.Ch8.Exercises.Customer

  test "Creating a struct" do
    s1 = %Subscriber{}
    assert s1.name == ""
  end

  test "Setting struct values" do
    s1 = %Subscriber{name: "Cory"}
    assert s1.name == "Cory"
    refute s1.paid

    s1 = %Subscriber{ s1 | paid: true}
    assert s1.paid
  end

  test "Struct specific behavior" do
    s1 = %Subscriber{name: "Cory", paid: false}
    assert Subscriber.send_paid_account_features_spam(s1)

    rich_subscriber = %Subscriber{name: "Cory", paid: true, over_18: true}
    refute Subscriber.send_paid_account_features_spam(rich_subscriber)

    assert Subscriber.send_investment_opportunity_spam(rich_subscriber)
  end

  test "Getting deep in some sweet structs" do
    report = %BugReport{
      owner: %Customer{ name: "Rufus the Dufus", company: "Cool Corporation Incorporated LLC"},
      details: "THE SSOFWAR EDOESNT EVEN WERK!!?!1111!!",
      severity: 8765456789876543456789876543456789
    }
    assert report.owner.name == "Rufus the Dufus"

    # This is uggo like Rufus's mom
    report = %BugReport{
      report | owner: %Customer{ report.owner | company: "Int'l Conspiracy Corp."}
    }
    assert report.owner.company == "Int'l Conspiracy Corp."
  end

  test "put_in macro and function" do
    # put_in and update_in are macros that do magic ninja kicks to nested Maps
    # see: https://github.com/elixir-lang/elixir/blob/08a19d07683511772d4c3521c594868cf2249a52/lib/elixir/lib/kernel.ex#L1831
    report = %BugReport{
      owner: %Customer{ name: "Rufus the Dufus", company: "Cool Corporation Incorporated LLC"},
      details: "THE SSOFWAR EDOESNT EVEN WERK!!?!1111!!",
      severity: 8765456789876543456789876543456789
    }
    report = put_in(report.owner.name, "Cory")
    assert report.owner.name == "Cory"

    # Making calls to the functions directy allows more dynamic access than the short-hand macros
    # Note: this isnt working currently for nested structs in the function form of put_in...
    # -> https://github.com/elixir-lang/elixir/issues/4126
    #
    # Stubbing the test w a regular map
    report = %{
      owner: %{
        name: "Cory"
      }
    }
    report = put_in(report,[:owner,:name], "Rufus the Dufus")
    assert report.owner.name == "Rufus the Dufus"
  end

  test "update_in macro and function" do
    report = %BugReport{
      owner: %Customer{ name: "Rufus the Dufus", company: "Cool Corporation Incorporated LLC"},
      details: "THE SSOFWAR EDOESNT EVEN WERK!!?!1111!!",
      severity: 8765456789876543456789876543456789
    }
    report = update_in(report.owner.name, &("Mr. " <> &1))
    assert report.owner.name == "Mr. Rufus the Dufus"

    # Making calls to the functions directy allows more dynamic access than the short-hand macros
    # Note: this isnt working currently for nested structs in the function form of update_in...
    # -> https://github.com/elixir-lang/elixir/issues/4126
    #
    # Stubbing the test w a regular map
    report = %{
      owner: %{
        name: "Mr. Rufus the Dufus"
      }
    }
    report = update_in(report, [:owner,:name], &( &1 <> " VIII"))
    assert report.owner.name == "Mr. Rufus the Dufus VIII"
  end

  test "get_and_update_in macro and function" do
    report = %BugReport{
      owner: %Customer{ name: "Rufus the Dufus", company: "Cool Corporation Incorporated LLC"},
      details: "THE SSOFWAR EDOESNT EVEN WERK!!?!1111!!",
      severity: 8765456789876543456789876543456789
    }
    # lets dock this guys rating for being a jerk w/ the details
    {old_rating, report} = get_and_update_in(report.owner.customer_rating, &{ &1, &1-1})
    assert old_rating == 10
    assert report.owner.customer_rating == 9
  end

  test "get_in macro" do
    authors = [
      %{ name: "José", lang: "Elixir"},
      %{ name: "Matz", lang: "Ruby"},
      %{ name: "Larry", lang: "Perl"},
    ]

    jose = List.first(authors)

    assert get_in(jose,[:name]) == "José"

    # In get_in and get_and_update_in you can pass a function and it'll apply that function
    languages_with_an_r = fn (:get, collection, next_fn) ->
      for row <- collection do
        if String.contains?(row.lang, "r") do
          next_fn.(row)
        end
      end
    end

    assert get_in(authors, [languages_with_an_r, :name]) == ["José", nil, "Larry"]
  end
end
