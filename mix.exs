defmodule VideoCompactor.MixProject do
  use Mix.Project

  def project do
    [
      app: :video_compactor,
      version: "0.1.0",
      elixir: "~> 1.18-rc",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.cobertura": :test
      ],
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {VideoCompactor.Application, []},
      extra_applications: [:logger, :mongodb_driver]
    ]
  end

  defp deps do
    [
      {:broadway_sqs, "~> 0.7"},
      {:ecto_sql, "~> 3.0"},
      {:ex_aws, "~> 2.1"},
      {:ex_aws_sqs, "~> 3.0"},
      {:ex_aws_s3, "~> 2.0"},
      {:hackney, "~> 1.9"},
      {:jason, "~> 1.4.4"},
      {:mint, "~> 1.0"},
      {:mox, "~> 1.0", only: :test},
      {:mimic, "~> 1.10", only: :test},
      {:excoveralls, "~> 0.18", only: :test},
      {:plug_cowboy, "~> 2.7.3"},
      {:poison, "~> 3.0"},
      {:sweet_xml, "~> 0.7"},
      {:req, "~> 0.4.0"},
      {:tesla, "~> 1.14"},
      {:uuid, "~> 1.1"},
      {:mongodb_driver, "~> 1.5.0"}
    ]
  end
end
