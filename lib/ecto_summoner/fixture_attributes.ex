defmodule EctoSummoner.FixtureAttributes do
  defmacro __using__(struct_keys) do
    quote do
      defstruct [derived_from: nil, module: nil, repo: nil] ++ unquote(struct_keys)
    end
  end
end

defmodule EctoSummoner.FixtureAttributes.Record do
  use EctoSummoner.FixtureAttributes

  def new(attrs) do
    struct!(__MODULE__, attrs)
  end
end

defmodule EctoSummoner.FixtureAttributes.Collection do
  use EctoSummoner.FixtureAttributes, count: 3

  def new(attrs) do
    struct!(__MODULE__, attrs)
  end
end
