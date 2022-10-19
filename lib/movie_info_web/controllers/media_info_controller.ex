defmodule MovieInfoWeb.MediaInfoController do
  use MovieInfoWeb, :controller
  use Phoenix.HTML

  alias MovieInfo.Movie
  alias MovieInfo.Movie.MediaInfo
  # TODO: Implement "action_fallback" for to handle errors

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

  # POST
  # TODO: Make this a GET request someday and rename it to something besides "movie_info_form"
  @spec show_form(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show_form(conn, params) do
    search_term =
      Map.fetch!(params, "search_term")
      |> String.replace(~r/\s+/, " ")
      |> html_escape()
      |> safe_to_string()

    conn
    |> put_flash(
      :info,
      "This is a flash info message for testing that will appear in the HTML by default thanks to what's in app.html.heex! Search term: " <>
        search_term
    )
    |> put_flash(
      :error,
      "This is a flash error message for testing that will appear in the HTML by default thanks to what's in app.html.heex!"
    )
    |> redirect(to: Routes.media_info_path(conn, :show, search_term))
  end
end
