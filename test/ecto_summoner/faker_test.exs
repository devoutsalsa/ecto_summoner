defmodule EctoSummoner.FakerTest do
  use ExUnit.Case

  alias EctoSummoner.Faker
  alias EctoSummoner.Log

  describe "&fake/1" do
    test "fakes the fakeable fields" do
      log_attrs = Faker.fake!(%Log{})
      assert Map.keys(log_attrs) == [:log]
      assert is_binary(log_attrs.log)
      assert String.length(log_attrs.log) > 0
    end
  end

  describe "&get_queryable_non_autogenerate_fields/1" do
    test "log" do
      assert Faker.get_queryable_non_autogenerate_fields(%Log{}) == %{log: :string}
    end
  end
end
