defmodule Discuss.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :password, :string
    field :email, :string
    field :phone_no, :integer
    field :is_active, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone_no, :password, :is_active])
    |> cast(:inserted_at, :naive_datetime)
    |> validate_required([:name, :email, :password])
    |> validate_confirmation(:password, messabe: "Confirmation password missmatched")
  end
end
