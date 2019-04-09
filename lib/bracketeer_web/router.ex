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

    get "/", PageController, :index
    get "/hello", HelloController, :index
    get "/hello/:code", HelloController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", BracketeerWeb do
  #   pipe_through :api
  # end
end
