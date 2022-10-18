defmodule MovieInfo.Movie.MediaInfo do
  use Ecto.Schema
  import Ecto.Changeset
  alias MovieInfo.Movie.MediaInfo

  embedded_schema do
    field :media_id, :string
    field :title, :string
  end

  @doc false
  def changeset(%MediaInfo{} = media_info, attrs) do
    media_info
    |> cast(attrs, [:media_id, :title])
    |> validate_required([:media_id, :title])
  end
end
