defmodule Discuss.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :slug, :string
    field :image, :string
    field :body, :string
    field :published, :boolean, default: false
    field :view_count, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :slug, :body, :published, :image, :view_count])
    |> validate_required([:title, :published, :image])
  end
end
