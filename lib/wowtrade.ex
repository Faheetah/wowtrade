defmodule Wowtrade do
  @moduledoc """
  Wowtrade keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def i() do
    Wowtrade.ItemImporter.import_items_from_file("../wow-classic-items/data/json/data.json")
  end
end
