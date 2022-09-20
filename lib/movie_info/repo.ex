defmodule MovieInfo.Repo do
  use Ecto.Repo,
    otp_app: :movie_info,
    adapter: Ecto.Adapters.Postgres
end
