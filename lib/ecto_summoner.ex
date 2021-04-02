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

    records = 
      case fixture_attributes do
        %Collection{count: count, module: module, repo: repo} -> 
          for _ <- 1..count do
            %Record{module: module, repo: repo}
          end
        record -> 
          [record]
      end

    records =
      for record <- records do
        attrs = Faker.fake!(record.module.__struct__)

        record.module.__struct__
        |> record.module.changeset(attrs)
        |> record.repo.insert!()
      end

    case fixture_attributes do
      %Collection{} -> 
        records
       _ -> 
        [record] = records
        record
    end
  end
end
