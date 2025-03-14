defmodule PromptTemplate.Repo.Migrations.CreateTemplates do
  use Ecto.Migration

  def change do
    create table(:templates) do
      add :name, :string
      add :body, :text

      timestamps(type: :utc_datetime)
    end
  end
end
