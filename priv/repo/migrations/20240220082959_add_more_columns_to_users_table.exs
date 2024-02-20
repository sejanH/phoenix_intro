defmodule Discuss.Repo.Migrations.AddMoreColumnsToUsersTable do
  use Ecto.Migration

  def change do

    alter table(:users) do
      add :user_role, :"ENUM('author','admin')", [default: ~c'admin', after: "password"]
    end
  end
end
