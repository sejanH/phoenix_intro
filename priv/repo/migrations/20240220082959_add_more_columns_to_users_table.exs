defmodule Discuss.Repo.Migrations.AddMoreColumnsToUsersTable do
  use Ecto.Migration

  def change do

    alter table(:users) do
      add :user_role, :tinyint, default: 1, comment: "1:author, 2:admin", after: "password"
    end
  end
end
