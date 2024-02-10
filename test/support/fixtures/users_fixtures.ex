defmodule Discuss.UsersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Discuss.Users` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        is_active: true,
        name: "some name",
        password: "some password"
      })
      |> Discuss.Users.create_user()

    user
  end
end
