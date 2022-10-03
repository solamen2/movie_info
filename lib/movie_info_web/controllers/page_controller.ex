defmodule MovieInfoWeb.PageController do
  use MovieInfoWeb, :controller
  use Phoenix.HTML
  alias MovieInfo.MovieInfo, as: MovieInfo

  def movie_info(conn, params) do
    search_term = Map.fetch!(params, "search_term")

    response = MovieInfo.fetch_imdb_data(search_term)
    headers_encoded = Enum.map(response.headers, &Tuple.to_list/1)

    media_item = Map.fetch!(response.body, "d") |> Enum.at(0)

    conn
    |> assign(:status, response.status |> html_escape() |> safe_to_string())
    |> assign(:media_item, Jason.encode!(media_item))
    |> assign(:headers, headers_encoded)
    |> render("index.html")
  end
end
