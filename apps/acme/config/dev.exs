use Mix.Config

config :acme, Acme.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "acme_dev",
  hostname: "localhost",
  pool_size: 20
