defmodule DiscussWeb.UserJSON do
  alias Discuss.Users.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      phone_no: "+880" <> Integer.to_string(user.phone_no),
      is_active: user.is_active,
      joined: DateTime.to_naive(user.inserted_at) |> NaiveDateTime.to_string(),
      post: Enum.count(user.posts)  > 0 && for(post <- user.posts, do: post |> DiscussWeb.PostJSON.data()) || []
    }
  end
end
