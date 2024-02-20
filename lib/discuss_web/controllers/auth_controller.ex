defmodule DiscussWeb.AuthController do
  use DiscussWeb, :controller

  alias Discuss.Users

  # action_fallback DiscussWeb.FallbackController

  def login(conn, data) do
    case Users.determine_type(data) do
      {:error, type} ->
        conn
        |> put_status(422)
        |> json(%{"status" => 422, "message" => type})

      {:ok, type} ->
        with {:ok, user} <-
               data
               |> Users.find_user_by_type(type)
               |> Users.verify_password(data),
             {:ok, token} <- Users.login_user(user) do
          conn
          |> json(%{
            "token" => token,
            "user" => %{
              "id" => user.id,
              "name" => user.name,
              "email" => user.email,
              "phone_no" => "+880" <> Integer.to_string(user.phone_no)
            }
          })
        else
          {:error, reason} ->
            conn |> put_status(401) |> json(%{"message" => reason})
        end
    end
  end
end
