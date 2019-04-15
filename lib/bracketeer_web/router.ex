defmodule BracketeerWeb.Router do
  use BracketeerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BracketeerWeb do
    pipe_through :browser

    
    # get "/hello", HelloController, :index
    # get "/hello/:code", HelloController, :show
    # get "/test", PageController, :test

    # #* Very Important for later: https://hexdocs.pm/phoenix/routing.html#path-helpers
    # resources "/users", UserController
    resources "/brackets", BracketController

    post "/join", BracketController, :get_bracket
    get "/", PageController, :index

    resources "/participants", ParticipantController
    resources "/matches", MatchController
  end

  scope "/manage", BracketeerWeb.Manager, as: :manager do
    pipe_through :browser

    resources "/users", UserController
  end


  # Routes.user_path(Endpoint, :index)
  # "/users"

  # Routes.user_path(Endpoint, :show, 17)
  # "/users/17"

  # Routes.user_path(Endpoint, :new)
  # "/users/new"

  # Routes.user_path(Endpoint, :create)
  # "/users"

  # Routes.user_path(Endpoint, :edit, 37)
  # "/users/37/edit"

  # Routes.user_path(Endpoint, :update, 37)
  # "/users/37"

  # Routes.user_path(Endpoint, :delete, 17)
  # "/users/17"

  #Use of queries:
  # Routes.user_path(Endpoint, :show, 17, admin: true, active: false)
  # "/users/17?admin=true&active=false"

  #Use of urls:
  #  Routes.user_url(Endpoint, :index)
  # "http://localhost:4000/users"

  # Other scopes may use custom stacks.
  # scope "/api", BracketeerWeb do
  #   pipe_through :api
  # end
end
