use Mix.Config

config :acme, Acme.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "acme_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
