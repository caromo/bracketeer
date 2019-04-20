defmodule BracketeerWeb.BracketView do
  use BracketeerWeb, :view
  require IEx
  alias Bracketeer.Rooms
  alias Bracketeer.Rooms.Scoreboard

  def get_count(id) do
    Rooms.count_players(id)
  end

  def get_rounds(id) do
    Rooms.round_count(id)
  end

  def get_player_by_id(id) do
    player = Rooms.get_player!(id)
    player
  end
  def get_room_by_id(id) do
    bracket = Rooms.get_bracket!(id)
    bracket.name
  end

  
  # * Valuable lesson here: Do NOT do Ecto logic in the template
  # * or the view. Process it THEN put it into the view!
  # ! def split_rankings_into_matches(rankings) do
  # !  pairs = Enum.chunk_every(rankings, 2)
  # !  test = Enum.map(pairs, fn x -> process_pair(x) end)
  # !  IEx.pry()
  # ! end
  # ! def process_pair([x, y]) do
  # !  [x_player: x.player_id, 
  # !  y_player: y.player_id,
  # !  tid: x.bracket_id]
  # ! end

end
