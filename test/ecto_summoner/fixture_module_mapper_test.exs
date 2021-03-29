defmodule EctoSummoner.FixtureModuleMapperTest do
  use ExUnit.Case

  alias EctoSummoner.FixtureAttributes
  alias EctoSummoner.FixtureModuleMapper
  alias EctoSummoner.GameConsole
  alias EctoSummoner.Log
  alias EctoSummoner.Manufacturer
  alias EctoSummoner.Peripheral
  alias EctoSummoner.RegisteredOwner
  alias EctoSummoner.Repo
  alias EctoSummoner.Warranty

  setup do
    %{default_repo: Repo}
  end

  describe "&map!/1" do
    test "returns finds value for 'log' atom key", %{default_repo: default_repo} do
      assert FixtureModuleMapper.map!(:log) == %FixtureAttributes.Record{
               derived_from: :module_basename,
               module: Log,
               repo: default_repo
             }
    end

    test "returns finds value for 'logs' atom key", %{default_repo: default_repo} do
      assert FixtureModuleMapper.map!(:logs) == %FixtureAttributes.Collection{
               count: 3,
               derived_from: :schema_source,
               module: Log,
               repo: default_repo
             }
    end
  end

  describe "&find_app_ecto_schema_modules/1" do
    test "returns Ecto Schema modules for app" do
      assert FixtureModuleMapper.find_app_ecto_schema_modules(:ecto_summoner) == [
               GameConsole,
               Log,
               Manufacturer,
               Peripheral,
               RegisteredOwner,
               Warranty
             ]
    end
  end

  describe "&underscore_modules_basenames/1" do
    test "returns module basenames as strings", %{default_repo: default_repo} do
      assert FixtureModuleMapper.underscore_modules_basenames(
               [
                 GameConsole,
                 Log,
                 Manufacturer
               ],
               default_repo
             ) == [
               {"game_console",
                %FixtureAttributes.Record{
                  derived_from: :module_basename,
                  module: GameConsole,
                  repo: default_repo
                }},
               {"log",
                %FixtureAttributes.Record{
                  derived_from: :module_basename,
                  module: Log,
                  repo: default_repo
                }},
               {"manufacturer",
                %FixtureAttributes.Record{
                  derived_from: :module_basename,
                  module: Manufacturer,
                  repo: default_repo
                }}
             ]
    end
  end

  describe "&get_ecto_schema_modules_table_names/1" do
    test "returns tables names as strings", %{default_repo: default_repo} do
      assert FixtureModuleMapper.get_ecto_schema_modules_table_names(
               [
                 GameConsole,
                 Log,
                 Manufacturer
               ],
               default_repo
             ) == [
               {"game_consoles",
                %FixtureAttributes.Collection{
                  count: 3,
                  derived_from: :schema_source,
                  module: GameConsole,
                  repo: default_repo
                }},
               {"logs",
                %FixtureAttributes.Collection{
                  count: 3,
                  derived_from: :schema_source,
                  module: Log,
                  repo: default_repo
                }},
               {"manufacturers",
                %FixtureAttributes.Collection{
                  count: 3,
                  derived_from: :schema_source,
                  module: Manufacturer,
                  repo: default_repo
                }}
             ]
    end
  end
end
