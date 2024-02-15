defmodule Discuss.Repo.Migrations.CreatePostMetas do
  use Ecto.Migration

  def change do
    create table(:post_metas) do
      add :post_id, references(:posts, column: "id")
      add :meta_key, :string
      add :meta_value, :text
    end
  end
end
