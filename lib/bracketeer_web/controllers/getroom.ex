defmodule BracketeerWeb.GetRoom do

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    rankings = get_session(conn, :curr)
    conn
    |> assign(:curr_rank, rankings)
  end
end
