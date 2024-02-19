defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller

  alias Discuss.Users

  # action_fallback DiscussWeb.FallbackController

  def login(conn, data) do
    type =
      data
      |> Users.determine_type()

    case data
         |> Users.sanitize_with_validate(type)
         |> Users.find_user_by_type(data, type)
         |> Users.verify_password(data)
         |> Users.login_user() do
      :error ->
        conn |> put_status(401) |> json(%{"message" => "Login failed"})

      result ->
        conn
        |> json(%{
          "token" => result["token"],
          "user" => %{
            "id" => result["user"].id,
            "name" => result["user"].name,
            "email" => String.replace(result["user"].email, ~r/(.{4})(?=@)/, "****"),
            "phone_no" =>
              String.replace("+880" <> Integer.to_string(result["user"].phone_no), ~r/\d{3}/, "*",
                global: true
              )
          }
        })
    end
  end
end
