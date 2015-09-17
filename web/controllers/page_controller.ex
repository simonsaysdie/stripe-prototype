defmodule Tolkien.PageController do
  use Tolkien.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
