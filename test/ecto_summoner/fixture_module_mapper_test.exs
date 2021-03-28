defmodule EctoSummoner.FixtureModuleMapperTest do
  use ExUnit.Case

  alias EctoSummoner.FixtureModuleMapper

  setup do
    %{default_repo: EctoSummoner.Repo}
  end

  describe "&map!/1" do
    test "returns finds value for 'log' atom key", %{default_repo: default_repo} do
      assert FixtureModuleMapper.map!(:log) == %{module: EctoSummoner.Log, repo: default_repo}
    end

    test "returns finds value for 'logs' atom key", %{default_repo: default_repo} do
      assert FixtureModuleMapper.map!(:logs) == %{module: EctoSummoner.Log, repo: default_repo}
    end
  end

  describe "&find_app_ecto_schema_modules/1" do
    test "returns Ecto Schema modules for app" do
      assert FixtureModuleMapper.find_app_ecto_schema_modules(:ecto_summoner) == [
               EctoSummoner.GameConsole,
               EctoSummoner.Log,
               EctoSummoner.Manufacturer,
               EctoSummoner.Peripheral,
               EctoSummoner.RegisteredOwner,
               EctoSummoner.Warranty
             ]
    end
  end

  describe "&underscore_modules_basenames/1" do
    test "returns module basenames as strings" do
      assert FixtureModuleMapper.underscore_modules_basenames([
               EctoSummoner.GameConsole,
               EctoSummoner.Log,
               EctoSummoner.Manufacturer
             ]) == [
               {"game_console", EctoSummoner.GameConsole},
               {"log", EctoSummoner.Log},
               {"manufacturer", EctoSummoner.Manufacturer}
             ]
    end
  end

  describe "&get_ecto_schema_modules_table_names/1" do
    test "returns tables names as strings" do
      assert FixtureModuleMapper.get_ecto_schema_modules_table_names([
               EctoSummoner.GameConsole,
               EctoSummoner.Log,
               EctoSummoner.Manufacturer
             ]) == [
               {"game_consoles", EctoSummoner.GameConsole},
               {"logs", EctoSummoner.Log},
               {"manufacturers", EctoSummoner.Manufacturer}
             ]
    end
  end
end
