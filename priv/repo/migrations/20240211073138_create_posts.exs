defmodule Discuss.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :body, :text
      add :excerpt, :string, size: 500
      add :published, :boolean, default: false
      add :image, :string, size: 500
      add :post_type, :integer, default: 1
      add :view_count, :integer, default: 0
      add :comment_count, :integer, default: 0
      add :post_parent, :integer, null: true

      timestamps(type: :utc_datetime)
    end
    create index(:posts, :post_type)
    create index(:posts, :published)
    create unique_index(:posts, :slug)
  end
end
