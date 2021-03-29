defmodule EctoSummoner do
  @moduledoc """
  Documentation for `EctoSummoner`.
  """

  alias EctoSummoner.FixtureModuleMapper
  alias EctoSummoner.Faker

  def summon!(fixture_key) do
    %{module: module, repo: repo} = FixtureModuleMapper.map!(fixture_key)
    attrs = Faker.fake!(module.__struct__)

    module.__struct__
    |> module.changeset(attrs)
    |> repo.insert!()
  end
end
