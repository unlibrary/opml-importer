defmodule OpmlImporter.MixProject do
  use Mix.Project

  def project do
    [
      app: :opml_importer,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:opml_parser, github: "jamesnolanverran/xml-opml-elixir"},
      {:unlib, path: "../reader"}
    ]
  end
end
