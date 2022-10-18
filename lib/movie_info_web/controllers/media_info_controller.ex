defmodule MovieInfoWeb.MediaInfoController do
  use MovieInfoWeb, :controller

  alias MovieInfo.Movie
  alias MovieInfo.Movie.MediaInfo

  def index(conn, _params) do
    raise "TODO: Implement index"
  end

  def show(conn, %{"search_term" => search_term}) do
    media_info = Movie.get_media_info!(search_term)

    # TODO: map the media info properly
    conn
    # TODO: Maybe can make this nicer with JSON rendering in Phoenix, see https://hexdocs.pm/phoenix/views.html#rendering-json
    |> assign(:search_term, search_term)
    |> render("show.html", media_info: media_info)
  end
end
