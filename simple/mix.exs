defmodule Simple.MixProject do
  use Mix.Project

  def project do
    [
      app: :simple,
      version: "0.1.1",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
    ]
  end

  defp deps do
    [
      {:pow, "1.0.15"},
      {:coherence, "0.5.1"},
    ]
  end
end


