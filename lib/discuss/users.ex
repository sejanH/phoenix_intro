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
    |> Repo.get!(id)
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
    (Regex.match?(~r/^[A-Za-z0-9\._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}$/, input) && "email") ||
      "phone"
  end

  @doc """
  Sanitize identifier input from users
  """
  # def sanitize_with_validate(type, attrs) do
  #   attrs |> validate_length()
  # end
  @doc """
  Login user and provide one token
  """
  def login_user(type, %{"identifier" => i, "password" => p}) do
    if type === "email" do
      query = from u in User, where: u.email == ^i
      user = Repo.one!(query)
      Bcrypt.verify_pass(p, user.password)
    else
      query = from u in User, where: u.phone_no == ^String.slice(i, -10, 10)
      user = Repo.one!(query)
      Bcrypt.verify_pass(p, user.password)
    end
  end
end
