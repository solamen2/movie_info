defmodule MovieInfoWeb.PageController do
  use MovieInfoWeb, :controller
  use Phoenix.HTML
  alias MovieInfo.MovieInfo, as: MovieInfo
  alias MovieInfoWeb.Router.Helpers, as: Routes

  # GET
  def movie_info(conn, params) do
    search_term = Map.fetch!(params, "search_term")

    response = MovieInfo.fetch_imdb_data(search_term)
    headers_encoded = Enum.map(response.headers, &Tuple.to_list/1)

    media_item = Map.fetch!(response.body, "d") |> Enum.at(0)

    conn
    |> assign(:search_term, search_term |> html_escape() |> safe_to_string())
    |> assign(:status, response.status |> html_escape() |> safe_to_string())
    |> assign(:media_item, Jason.encode!(media_item))
    |> assign(:headers, headers_encoded)
    |> render("index.html")
  end

  # POST
  @spec movie_info_form(Plug.Conn.t(), map) :: Plug.Conn.t()
  def movie_info_form(conn, params) do
    search_term =
      Map.fetch!(params, "search_term")
      |> String.replace(~r/\s+/, " ")
      |> html_escape()
      |> safe_to_string()

    conn
    |> redirect(to: Routes.page_path(conn, :movie_info, search_term))
  end
end
