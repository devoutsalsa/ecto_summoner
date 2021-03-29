defmodule EctoSummonerTest do
  use ExUnit.Case

  alias EctoSummoner.Log

  describe "&/summon!" do
    test ":logs returns 1 log" do
      assert match?(%Log{}, EctoSummoner.summon!(:log))
    end

    test ":logs returns 3 logs" do
      logs = EctoSummoner.summon!(:logs)
      assert match?([%Log{}, %Log{}, %Log{}], logs)
    end
  end
end
