defmodule Bracketeer.Repo do
  use Ecto.Repo,
    otp_app: :bracketeer,
    adapter: Ecto.Adapters.Postgres
end
