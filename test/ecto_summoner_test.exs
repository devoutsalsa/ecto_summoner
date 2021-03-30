defmodule EctoSummonerTest do
  use ExUnit.Case

  alias EctoSummoner.GameConsole
  alias EctoSummoner.Log
  alias EctoSummoner.Manufacturer
  alias EctoSummoner.RegisteredOwner
  alias EctoSummoner.Peripheral
  alias EctoSummoner.Warranty

  describe "&/summon!" do
    test ":game_console returns 1 game console" do
      assert match?(%GameConsole{}, EctoSummoner.summon!(:game_console))
    end

    test ":logs returns 1 log" do
      assert match?(%Log{}, EctoSummoner.summon!(:log))
    end

    test ":logs returns 3 logs" do
      assert match?([%Log{}, %Log{}, %Log{}], EctoSummoner.summon!(:logs))
    end

    test ":manufacturer returns 1 manufacturer" do
      assert match?(%Manufacturer{}, EctoSummoner.summon!(:manufacturer))
    end

    test ":peripheral returns 1 peripheral" do
      assert match?(%Peripheral{}, EctoSummoner.summon!(:peripheral))
    end

    test ":registered_owner returns 1 registered owner" do
      assert match?(%RegisteredOwner{}, EctoSummoner.summon!(:registered_owner))
    end

    test ":warranty returns 1 warranty" do
      assert match?(%Warranty{}, EctoSummoner.summon!(:warranty))
    end
  end
end
