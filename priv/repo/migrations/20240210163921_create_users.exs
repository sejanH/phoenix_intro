defmodule Discuss.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, size: 50, null: false
      add :email, :string, size: 191
      add :phone_no, :integer, null: true
      add :password, :string, size: 191
      add :is_active, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)

    end
    create unique_index(:users,[:phone_no])
  end
end
