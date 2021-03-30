defmodule EctoSummoner do
  @moduledoc """
  Documentation for `EctoSummoner`.
  """

  alias EctoSummoner.FixtureAttributes.Collection
  alias EctoSummoner.FixtureAttributes.Record
  alias EctoSummoner.FixtureModuleMapper
  alias EctoSummoner.Faker

  def summon!(fixture_key) do
    fixture_attributes = FixtureModuleMapper.map!(fixture_key)

    case fixture_attributes do
      %Collection{count: count, module: module, repo: repo} ->
        1..count
        |> Enum.map(fn _ ->
          attrs = Faker.fake!(module.__struct__)

          module.__struct__
          |> module.changeset(attrs)
          |> repo.insert!()
        end)

      %Record{module: module, repo: repo} ->
        attrs = Faker.fake!(module.__struct__)

        module.__struct__
        |> module.changeset(attrs)
        |> repo.insert!()
    end
  end
end
