defmodule MovieInfo.MovieFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MovieInfo.Movie` context.
  """

  @doc """
  Generate a media_info.
  """
  def media_info_fixture(attrs \\ %{}) do
    {:ok, media_info} =
      attrs
      |> Enum.into(%{
        media_id: "some media_id",
        title: "some title"
      })
      |> MovieInfo.Movie.create_media_info()

    media_info
  end
end
