defmodule Discuss.PostMeta do
  use Ecto.Schema
  import Ecto.Changeset

  schema "post_metas" do
    field :post_id, :integer
    field :meta_key, :string
    field :meta_value, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post_meta, attrs) do
    post_meta
    |> cast(attrs, [:post_id, :meta_key, :meta_value])
    |> validate_required([:post_id, :meta_key, :meta_value])
  end
end
