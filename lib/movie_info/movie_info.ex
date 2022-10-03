defmodule MovieInfo.MovieInfo do
  use Tesla

  plug Tesla.Middleware.BaseUrl,
       "https://v2.sg.media-imdb.com/suggestion/h"

  # plug Tesla.Middleware.Headers, [{"authorization", "token xyz"}]
  plug Tesla.Middleware.JSON

  def fetch_imdb_data(search_term) do
    {:ok, response} = get(search_term <> ".json")
    response
  end
end
