defmodule BracketeerWeb.GetRoom do

  import Plug.Conn
  alias Bracketeer.Rooms

  def init(opts), do: opts

  def call(conn, _opts) do
    roomid = get_session(conn, :curr_id)
    currroom = roomid && Rooms.get_bracket(roomid)

    conn
    |> assign(:current_room, currroom)
  end
end
