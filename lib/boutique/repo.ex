defmodule Boutique.Repo do
  use Ecto.Repo,
    otp_app: :boutique,
    adapter: Ecto.Adapters.Postgres
end
