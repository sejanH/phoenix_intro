defmodule Discuss.Repo.Migrations.CreateTaxonomies do
  use Ecto.Migration

  def change do
    create table(:taxonomies) do
      add :name, :string, size: 120
      add :slug, :string, size: 150
      add :parent_id, references(:taxonomies, column: "id") , null: true
      add :is_active, :boolean, default: false, null: false
      add :post_count, :integer, default: 0, null: true
      add :hierarchy_level, :integer, default: 0, null: true

      timestamps(type: :utc_datetime)
    end
    create unique_index(:taxonomies, :slug)

    create table(:post_taxonomies, primary_key: false) do
      add :taxonomy_id, references(:taxonomies, column: "id", on_delete: :delete_all)
      add :post_id, references(:posts, column: "id", on_delete: :delete_all)
    end
  end
end
