defmodule BracketeerWeb.MatchView do
  use BracketeerWeb, :view
  alias BracketeerWeb.MatchView

  def render("index.json", %{matches: matches}) do
    %{data: render_many(matches, MatchView, "match.json")}
  end

  def render("show.json", %{match: match}) do
    %{data: render_one(match, MatchView, "match.json")}
  end

  def render("match.json", %{match: match}) do
    %{id: match.id,
      draw: match.draw}
  end
end
