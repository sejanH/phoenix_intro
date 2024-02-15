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
    field :author_id, :integer
    field :excerpt, :string
    field :post_type, :integer
    field :comment_count, :integer
    field :post_parent, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [
      :title,
      :slug,
      :body,
      :published,
      :image,
      :view_count,
      :excerpt,
      :post_type,
      :comment_count,
      :post_parent
    ])
    |> validate_required([:title, :published, :image])
  end
end
