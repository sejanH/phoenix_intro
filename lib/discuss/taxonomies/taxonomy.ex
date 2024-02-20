defmodule Discuss.Taxonomies.Taxonomy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "taxonomies" do
    field :name, :string
    field :slug, :string
    field :parent_id, :integer
    field :is_active, :boolean, default: false
    field :post_count, :integer
    field :hierarchy_level, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(taxonomy, attrs) do
    taxonomy
    |> cast(attrs, [:name, :slug, :parent_id, :is_active, :post_count, :hierarchy_level])
    |> validate_required([:name, :slug, :parent_id, :is_active, :post_count, :hierarchy_level])
  end
end
