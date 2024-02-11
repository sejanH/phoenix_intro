defmodule Discuss.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string, null: false
      add :slug, :string, null: false
      add :body, :text
      add :published, :boolean, default: false
      add :image, :string, size: 500
      add :view_count, :integer, default: 0

      timestamps(type: :utc_datetime)
    end
  end
end
