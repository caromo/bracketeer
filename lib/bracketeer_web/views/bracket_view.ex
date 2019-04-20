defmodule BracketeerWeb.BracketView do
  use BracketeerWeb, :view
  alias Bracketeer.Rooms
  alias Bracketeer.Rooms.Scoreboard
  def get_count(id) do
    Rooms.count_players(id)
  end

  def get_rounds(id) do
    Rooms.round_count(id)
  end

  def split_rankings_into_matches(rankings) do
    pairs = Enum.chunk_every(rankings, 2)
    Enum.map(pairs, fn x -> process_pair(x) end)
  end

  def process_pair([x, y]) do
    [x_player: x.player, 
    y_player: y.player]
  end
end
