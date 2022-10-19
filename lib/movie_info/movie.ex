defmodule MovieInfo.Movie do
  @moduledoc """
  The Movie context.
  """

  import Ecto.Query, warn: false
  alias MovieInfo.Repo
  alias MovieInfo.Movie.MediaInfo
  alias MovieInfo.GetImdbInfo

  @doc """
  Returns the list of media_info.

  ## Examples

      iex> list_media_info()
      [%MediaInfo{}, ...]

  """
  def list_media_info do
    raise "TODO"
  end

  @doc """
  Gets a single media_info.

  Raises if the Media info does not exist.

  ## Examples

      iex> get_media_info!(123)
      %MediaInfo{}

  """
  def get_media_info!(search_term) do
    response = GetImdbInfo.fetch_imdb_data(search_term)
    # headers_encoded = Enum.map(response.headers, &Tuple.to_list/1)

    media_item = Map.fetch!(response.body, "d") |> Enum.at(0)
    %MediaInfo{:media_id => media_item["id"], :title => media_item["l"]}
  end

  # TODO: Implement "action_fallback" for to handle errors

  # POST
  # TODO: Make this a GET request someday and rename it to something besides "movie_info_form"
  def movie_info_form(conn, params) do
    # search_term =
    #   Map.fetch!(params, "search_term")
    #   |> String.replace(~r/\s+/, " ")
    #   |> html_escape()
    #   |> safe_to_string()

    # conn
    # |> put_flash(
    #   :info,
    #   "This is a flash info message for testing that will appear in the HTML by default thanks to what's in app.html.heex! Search term: " <>
    #     search_term
    # )
    # |> put_flash(
    #   :error,
    #   "This is a flash error message for testing that will appear in the HTML by default thanks to what's in app.html.heex!"
    # )
    # |> redirect(to: Routes.page_path(conn, :get_media_info, search_term))
  end
end
