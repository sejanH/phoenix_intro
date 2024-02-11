defmodule Discuss.Repo.Migrations.PostsAddMoreColumn do
  use Ecto.Migration

  def change do
    alter table("posts") do
      add :author_id, references(:users, column: "id"), after: "image"
    end
  end
end
