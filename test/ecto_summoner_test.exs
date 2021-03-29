defmodule EctoSummonerTest do
  use ExUnit.Case

  alias EctoSummoner.Log

  describe "&/summon!" do
    test "returns a log" do
      assert match?(%Log{}, EctoSummoner.summon!(:log))
    end
  end
end
