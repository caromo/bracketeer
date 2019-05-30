defmodule BracketeerWeb.Router do
  use BracketeerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    # plug BracketeerWeb.GetRoom
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BracketeerWeb do
    pipe_through :browser

    get "/players/in/:id", PlayerController, :index_for_tourney
    get "/report", BracketController, :report_match
    post "/makematch", BracketController, :make_match
    get "/bye", BracketController, :report_bye

    resources "/brackets", BracketController
    resources "/players", PlayerController

    post "/join", BracketController, :get_bracket
    get "/", PageController, :index
  end

  scope "/api", BracketeerWeb do
    pipe_through :api

    resources "/scoreboards", ScoreboardController, except: [:new, :edit]
    resources "/matches", MatchController, except: [:new, :edit]
  end
  
end
