defmodule Elixir.Mixfile do
  use Mix.Project

  def project do
    [ app: :elixir,
      version: "0.0.1",
      elixir: "~> 1.0",
      deps: deps
    ]
  end

  def application do
    [ applications: [ :logger ] ]
  end

  defp deps do
    []
  end
end