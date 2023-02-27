import Config

config :logger,
  level: :error

config :unlib,
  ecto_repos: [UnLib.Repo]

config :unlib, UnLib.Repo,
  migration_primary_key: [
    name: :id,
    type: :uuid
  ]

import_config "#{Mix.env()}.exs"
