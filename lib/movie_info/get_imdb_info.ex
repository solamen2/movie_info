defmodule MovieInfo.GetImdbInfo do
  use Tesla

  plug Tesla.Middleware.BaseUrl,
       "https://v2.sg.media-imdb.com/suggestion/h"

  # plug Tesla.Middleware.Headers, [{"authorization", "token xyz"}]
  plug Tesla.Middleware.JSON

  def fetch_imdb_data(search_term) do
    # FYI: Models go in the directory at the same level as movie_info.ex, but will be in different files.
    search_term =
      search_term
      |> URI.decode()
      |> String.replace(~r/\s+/, "_")

    IO.inspect("Search term is: " <> search_term)
    {:ok, response} = get(search_term <> ".json")
    response
  end
end
