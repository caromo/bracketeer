defmodule BracketeerWeb.PlayerView do
  require IEx
  use BracketeerWeb, :view
  alias Bracketeer.Rooms
  def room_select_options(rooms) do
    for room <- rooms, do: {room.name, room.id}
  end

  def get_name_by_id(id) do
    bracket = Rooms.get_bracket!(id)
    bracket.name
  end
end
