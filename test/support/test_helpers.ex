defmodule Bracketeer.TestHelpers do
    alias Bracketeer.Rooms
    alias Bracketeer.Rooms.Bracket
    alias Bracketeer.Rooms.Player

    def room_fixture(attrs \\ %{}) do
        name = "room#{System.unique_integer([:positive])}"

        {:ok, bracket} =
            attrs
            |> Enum.into(%{
                name: "Some Room"
                # edit_key: "testing"
            })
            |> Rooms.create_bracket()

        bracket
    end

    def user_fixture(%Rooms.Bracket{} = bracket, attrs \\ %{}) do
        attrs = 
            Enum.into(attrs, %{
                name: "user#{System.unique_integer([:positive])}"
                # rating: 1200
                # bracket: bracket
            })
        {:ok, user} = Rooms.create_player(attrs)

        user
    end
end