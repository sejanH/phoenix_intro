defmodule DiscussWeb.PageController do
  use DiscussWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, page_title: "Home", layout: false)
  end

  def hello(conn, _params) do
    page_title = "Hello"
    render(conn, :hello, layout: false, page_title: page_title)
  end
end
