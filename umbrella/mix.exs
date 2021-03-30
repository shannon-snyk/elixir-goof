defmodule Umbrella.MixProject do
  use Mix.Project

  def project do
    [
      app: :umbrella,
      version: "0.3.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      apps_path: "apps"
    ]
  end

  defp deps do
    []
  end
end


