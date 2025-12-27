defmodule LittlechatWeb.PageController do
  use LittlechatWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
