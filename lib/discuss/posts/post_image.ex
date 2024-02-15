defmodule Discuss.Posts.PostImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_images" do
    field :post_id, :integer
    field :path, :string
    field :mime_type, :string
    field :file_size, :string
    field :file_extension, :string
    field :uploader_id, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post_image, attrs) do
    post_image
    |> cast(attrs, [:post_id, :path, :mime_type, :file_size, :file_extension, :uploader_id])
    |> validate_required([:post_id, :path, :mime_type, :file_size, :file_extension, :uploader_id])
  end
end
