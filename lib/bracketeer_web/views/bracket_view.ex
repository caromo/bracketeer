defmodule BracketeerWeb.BracketView do
  use BracketeerWeb, :view
  alias Bracketeer.Rooms
  def get_count(id) do
    Rooms.count_players(id)
  end

  def get_rounds(id) do
    Rooms.round_count(id)
  end
end
