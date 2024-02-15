defmodule Discuss.Repo.Migrations.CreatePostImages do
  use Ecto.Migration

  def change do
    create table(:post_images) do
      add :post_id, references(:posts, [column: "id", ondelete: "cascade"])
      add :path, :string, size: 191
      add :mime_type, :string, size: 40
      add :file_size, :string, size: 40
      add :file_extension, :string, size: 10
      add :uploader_id, references(:users, [column: "id", ondelete: "cascade"])

      timestamps(type: :utc_datetime)
    end
  end
end
