defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller

  alias Discuss.Users

  # action_fallback DiscussWeb.FallbackController

  def login(conn, data) do
    result =
      data
      |> Users.determine_type()
      |> Users.sanitize_with_validate(data)
      |> Users.verify_password(data)
      |> Users.login_user()

      # IO.inspect(Regex.replace("+880" <> Integer.to_string(result["user"].phone_no), ~r{^(\d{3})(\d{3}).*(\d{3})$}, "\\1***\\3"))
    conn
    |> json(%{
      "token" => result["token"],
      "user" => %{
        "id" => result["user"].id,
        "name" => result["user"].name,
        "email" => String.replace(result["user"].email, ~r/(.{4})(?=@)/, "****"),
        "phone_no" => String.replace("+880" <> Integer.to_string(result["user"].phone_no), ~r/\d{3}/,"*", global: true)
      }
    })
  end
end
