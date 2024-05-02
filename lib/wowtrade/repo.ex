defmodule Wowtrade.Repo do
  use Ecto.Repo,
    otp_app: :wowtrade,
    adapter: Ecto.Adapters.Postgres
end
