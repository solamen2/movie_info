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
  Gets a single media_info for a search term.

  Raises if the Media info does not exist.

  ## Examples

      iex> get_media_info!("inception")
      %MediaInfo{}

  """
  def get_media_info!(search_term) do
    response = GetImdbInfo.fetch_imdb_data(search_term)
    # headers_encoded = Enum.map(response.headers, &Tuple.to_list/1)

    media_item = Map.fetch!(response.body, "d") |> Enum.at(0)
    %MediaInfo{:media_id => media_item["id"], :title => media_item["l"]}
  end

  # TODO: Implement "action_fallback" to handle errors
end
