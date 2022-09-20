defmodule MovieInfoWeb.PageController do
  use MovieInfoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
