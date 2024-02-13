defmodule Discuss.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.Posts.Post

  schema "users" do
    field :name, :string
    field :password, :string
    field :email, :string
    field :phone_no, :integer
    field :is_active, :boolean, default: false

    timestamps(type: :utc_datetime)
    has_many :posts, Post, [foreign_key: :author_id]
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone_no, :password, :is_active])
    |> validate_required([:name, :email, :password])
    |> validate_confirmation(:password, message: "Confirmation password missmatched")
    |> validate_length(:password, min: 6, max: 190)
    |> hashpw()
    |> process_phone_no()
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:phone_no)
  end

  def hashpw(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Bcrypt.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end

  def process_phone_no(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{phone_no: phone_no}} ->
        put_change(
          changeset,
          :phone_no,
          Integer.to_string(phone_no)
          |> String.slice(-10, 10)
          |> String.to_integer()
        )

      _ ->
        changeset
    end
  end
end
