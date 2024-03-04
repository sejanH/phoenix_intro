defmodule Discuss.Repo.Migrations.AddRoleToUsers do
  use Ecto.Migration

  def up do
    execute "ALTER TABLE users ADD user_role ENUM('admin','author','moderator') NOT NULL DEFAULT 'author' AFTER `password`"
  end

  def down do
    alter table(:users) do
      remove :user_role
    end
  end
end
