defmodule Wowtrade.Repo.Migrations.CreatePrices do
  use Ecto.Migration

  def change do
    create table(:prices) do
      add :auction_id, :integer
      add :item_id, :integer
      add :bid, :integer
      add :buyout, :integer
      add :quantity, :integer
      add :time_left, :string
      add :realm, :integer
      add :auction_house, :integer

      timestamps(type: :utc_datetime)
    end

    create index(:prices, :item_id)
    create unique_index(:prices, :auction_id)
  end
end
