defmodule MovieInfoWeb.PageController do
  use MovieInfoWeb, :controller
  use Phoenix.HTML
  alias MovieInfo.MovieInfo, as: MovieInfo
  # Alias below can be removed I believe, in views and controllers and templates
  alias MovieInfoWeb.Router.Helpers, as: Routes
  # TODO: Implement "action_fallback" for to handle errors

  # GET
  # TODO: Probably this should be "show" after the router uses "resources", see https://hexdocs.pm/phoenix/controllers.html#actions
  @spec movie_info(Plug.Conn.t(), map) :: Plug.Conn.t()
  def movie_info(conn, %{"search_term" => search_term} = params) do
    response = MovieInfo.fetch_imdb_data(search_term)
    IO.inspect(params)
    headers_encoded = Enum.map(response.headers, &Tuple.to_list/1)

    media_item = Map.fetch!(response.body, "d") |> Enum.at(0)

    conn
    # TODO: Maybe can make this nicer with JSON rendering in Phoenix, see https://hexdocs.pm/phoenix/views.html#rendering-json
    |> assign(:search_term, search_term |> html_escape() |> safe_to_string())
    |> assign(:status, response.status |> html_escape() |> safe_to_string())
    |> assign(:media_item, Jason.encode!(media_item))
    |> assign(:headers, headers_encoded)
    |> render("index.html", controller_test: "Hi from the controller!")
  end

  # POST
  # TODO: Make this a GET request someday and rename it to something besides "movie_info_form"
  @spec movie_info_form(Plug.Conn.t(), map) :: Plug.Conn.t()
  def movie_info_form(conn, params) do
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
    |> redirect(to: Routes.page_path(conn, :movie_info, search_term))
  end
end
