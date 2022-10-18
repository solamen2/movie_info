defmodule MovieInfoWeb.MediaInfoControllerTest do
  use MovieInfoWeb.ConnCase

  import MovieInfo.MovieFixtures

  @create_attrs %{media_id: "some media_id", title: "some title"}
  @update_attrs %{media_id: "some updated media_id", title: "some updated title"}
  @invalid_attrs %{media_id: nil, title: nil}

  describe "index" do
    test "lists all media_info", %{conn: conn} do
      conn = get(conn, Routes.media_info_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Media info"
    end
  end

  describe "new media_info" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.media_info_path(conn, :new))
      assert html_response(conn, 200) =~ "New Media info"
    end
  end

  describe "create media_info" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.media_info_path(conn, :create), media_info: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.media_info_path(conn, :show, id)

      conn = get(conn, Routes.media_info_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Media info"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.media_info_path(conn, :create), media_info: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Media info"
    end
  end

  describe "edit media_info" do
    setup [:create_media_info]

    test "renders form for editing chosen media_info", %{conn: conn, media_info: media_info} do
      conn = get(conn, Routes.media_info_path(conn, :edit, media_info))
      assert html_response(conn, 200) =~ "Edit Media info"
    end
  end

  describe "update media_info" do
    setup [:create_media_info]

    test "redirects when data is valid", %{conn: conn, media_info: media_info} do
      conn = put(conn, Routes.media_info_path(conn, :update, media_info), media_info: @update_attrs)
      assert redirected_to(conn) == Routes.media_info_path(conn, :show, media_info)

      conn = get(conn, Routes.media_info_path(conn, :show, media_info))
      assert html_response(conn, 200) =~ "some updated media_id"
    end

    test "renders errors when data is invalid", %{conn: conn, media_info: media_info} do
      conn = put(conn, Routes.media_info_path(conn, :update, media_info), media_info: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Media info"
    end
  end

  describe "delete media_info" do
    setup [:create_media_info]

    test "deletes chosen media_info", %{conn: conn, media_info: media_info} do
      conn = delete(conn, Routes.media_info_path(conn, :delete, media_info))
      assert redirected_to(conn) == Routes.media_info_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.media_info_path(conn, :show, media_info))
      end
    end
  end

  defp create_media_info(_) do
    media_info = media_info_fixture()
    %{media_info: media_info}
  end
end
