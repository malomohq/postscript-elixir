defmodule Postscript.MixProject do
  use Mix.Project

  def project do
    [
      app: :postscript,
      version: "1.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      dialyzer: dialyzer(),
      elixirc_paths: elixirc_paths(Mix.env()),
      package: package()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      { :hackney, "~> 1.17", optional: true },

      { :jason, "~> 1.2", optional: true },

      #
      # dev
      #

      { :dialyxir, "~> 1.0", only: :dev, runtime: false },

      { :ex_doc, ">= 0.0.0", only: :dev, runtime: false }
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:hackney],
      plt_core_path: "_build/#{Mix.env()}"
    ]
  end

  defp elixirc_paths(:test) do
    ["lib/", "test/"]
  end

  defp elixirc_paths(_env) do
    ["lib/"]
  end

  defp package do
    %{
      # Private Hex.org organization package. Publish with a Malomo org member
      # account after creating the org at https://hex.pm/dashboard (paid seats
      # required for private packages). Consumers must set organization: "malomo".
      organization: "malomo",

      description: "Elixir client for the Postscript API",

      maintainers: ["Jason Cartwright"],

      licenses: ["MIT"],

      links: %{
        GitHub: "https://github.com/malomohq/postscript-elixir",

        "Made by Malomo - Post-purchase experiences that customers love": "https://gomalomo.com"
      }
    }
  end
end
