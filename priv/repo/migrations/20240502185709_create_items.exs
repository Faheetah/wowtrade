defmodule Wowtrade.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :item_id, :integer
      add :name, :string
      add :class, :string
      add :subclass, :string
      add :sell_price, :integer
      add :quality, :string
      add :item_level, :integer
      add :required_level, :integer
      add :slot, :string
      add :tooltip, :string
      add :item_link, :string
      add :vendor_price, :integer
      add :content_phase, :integer
      add :unique_name, :string
    end

    create unique_index(:items, [:item_id])
  end
end
