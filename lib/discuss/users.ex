defmodule Discuss.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Discuss.Repo

  alias Discuss.Users.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
    |> Repo.preload(:posts)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id) do
    User
    |> order_by(asc: :id)
    |> Repo.get(id)
    |> Repo.preload(:posts)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  @doc """
  determine type of the input if its email or phone number
  """
  def determine_type(%{"identifier" => input}) do
    is_email = Regex.match?(~r/^[A-Za-z0-9\._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$/, input)
    is_phone = Regex.match?(~r/^\+[0-9]*$/, input)

    cond do
      is_email ->
        {:ok, "email"}

      !is_email && is_phone ->
        {:ok, "phone"}

      !is_email && !is_phone ->
        {:error, "Email/Phone is not valid"}
    end
  end

  @doc """
  Login user and provide one token
  """
  def login_user(user) do
    {:ok, Phoenix.Token.sign(DiscussWeb.Endpoint, "user auth", user)}
  end

  def verify_password(attrs, %{"password" => p}) do
    case attrs do
      {:ok, user} ->
        if Bcrypt.verify_pass(p, user.password) do
          {:ok, user}
        else
          {:error, "password not matched"}
        end

      {:error, reason} ->
        {:error, reason}
    end
  end

  def find_user_by_type(%{"identifier" => i}, type \\ "email") do
    if type === "email" do
      query = from u in User, where: u.email == ^i

      case Repo.one(query) do
        nil ->
          {:error, "user not found"}

        user ->
          {:ok, user}
      end
    else
      query = from u in User, where: u.phone_no == ^String.slice(i, -10, 10)

      case Repo.one(query) do
        nil ->
          {:error, "user not found"}

        user ->
          {:ok, user}
      end
    end
  end
end
