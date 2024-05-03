defmodule Wowtrade.Repo.Migrations.CreatePrices do
  use Ecto.Migration

  def change do
    create table(:prices) do
      add :price, :integer
      add :item_id, references(:items, column: :item_id, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:prices, [:item_id])
  end
end
