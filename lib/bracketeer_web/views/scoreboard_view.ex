defmodule BracketeerWeb.ScoreboardView do
  use BracketeerWeb, :view
  alias BracketeerWeb.ScoreboardView

  def render("index.json", %{scoreboards: scoreboards}) do
    %{data: render_many(scoreboards, ScoreboardView, "scoreboard.json")}
  end

  def render("show.json", %{scoreboard: scoreboard}) do
    %{data: render_one(scoreboard, ScoreboardView, "scoreboard.json")}
  end

  def render("scoreboard.json", %{scoreboard: scoreboard}) do
    %{id: scoreboard.id,
      score: scoreboard.score,
      matches: scoreboard.matches,
      byes: scoreboard.byes}
  end
end
