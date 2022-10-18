defmodule MovieInfo.MovieTest do
  use MovieInfo.DataCase

  alias MovieInfo.Movie

  describe "media_info" do
    alias MovieInfo.Movie.MediaInfo

    import MovieInfo.MovieFixtures

    @invalid_attrs %{media_id: nil, title: nil}

    test "list_media_info/0 returns all media_info" do
      media_info = media_info_fixture()
      assert Movie.list_media_info() == [media_info]
    end

    test "get_media_info!/1 returns the media_info with given id" do
      media_info = media_info_fixture()
      assert Movie.get_media_info!(media_info.id) == media_info
    end

    test "create_media_info/1 with valid data creates a media_info" do
      valid_attrs = %{media_id: "some media_id", title: "some title"}

      assert {:ok, %MediaInfo{} = media_info} = Movie.create_media_info(valid_attrs)
      assert media_info.media_id == "some media_id"
      assert media_info.title == "some title"
    end

    test "create_media_info/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Movie.create_media_info(@invalid_attrs)
    end

    test "update_media_info/2 with valid data updates the media_info" do
      media_info = media_info_fixture()
      update_attrs = %{media_id: "some updated media_id", title: "some updated title"}

      assert {:ok, %MediaInfo{} = media_info} = Movie.update_media_info(media_info, update_attrs)
      assert media_info.media_id == "some updated media_id"
      assert media_info.title == "some updated title"
    end

    test "update_media_info/2 with invalid data returns error changeset" do
      media_info = media_info_fixture()
      assert {:error, %Ecto.Changeset{}} = Movie.update_media_info(media_info, @invalid_attrs)
      assert media_info == Movie.get_media_info!(media_info.id)
    end

    test "delete_media_info/1 deletes the media_info" do
      media_info = media_info_fixture()
      assert {:ok, %MediaInfo{}} = Movie.delete_media_info(media_info)
      assert_raise Ecto.NoResultsError, fn -> Movie.get_media_info!(media_info.id) end
    end

    test "change_media_info/1 returns a media_info changeset" do
      media_info = media_info_fixture()
      assert %Ecto.Changeset{} = Movie.change_media_info(media_info)
    end
  end
end
