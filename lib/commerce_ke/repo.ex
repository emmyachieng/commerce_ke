defmodule CommerceKe.Repo do
  use Ecto.Repo,
    otp_app: :commerce_ke,
    adapter: Ecto.Adapters.Postgres
end
