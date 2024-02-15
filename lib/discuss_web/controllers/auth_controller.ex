defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller

  alias Discuss.Users

  action_fallback DiscussWeb.FallbackController

  def login(conn, %{"data" => data}) do
    r =
      data
      |> Users.determine_type()
      # |> Users.sanitize_with_validate(data)
      |> Users.login_user(data)

    IO.inspect(r)

    conn
    |> json(data)
  end
end
